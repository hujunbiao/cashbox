#[macro_use]
extern crate serde_derive;

use ethabi::Contract;
use ethereum_types::{U256, H160};
use rlp::RlpStream;
use secp256k1::{Message, Secp256k1, key::{PublicKey, SecretKey},};
use bip39::{Mnemonic, Language,Seed};
use tiny_hderive::bip32::ExtendedPrivKey;

mod contract;
mod types;
mod error;

pub use error::Error;

// 从助记词恢复私钥
pub fn pri_from_mnemonic(phrase:&str,psd:Option<Vec<u8>>)->Result<Vec<u8>,error::Error>{
    let mnemonic = Mnemonic::from_phrase(phrase, Language::English)?;
    let psd = {
        match psd {
            Some(data)=>String::from_utf8(data)?,
            None=>String::from(""),
        }
    };
    let seed = Seed::new(&mnemonic,&psd);//
    let ext_key = ExtendedPrivKey::derive(&seed.as_bytes(), "m/44'/60'/0'/0/0")?;
    Ok(ext_key.secret().to_vec())
}
//从非压缩公钥生成ETH地址
pub fn generate_eth_address(secret_byte: &[u8]) -> Result<(String,String),error::Error> {
    let context = Secp256k1::new();
    //todo 增加错误处理
    let secret = SecretKey::from_slice(&secret_byte)?;
    let public_key = PublicKey::from_secret_key(&context, &secret);
    //一个是非压缩公钥 用于地址生成
    let puk_uncompressed = &public_key.serialize_uncompressed()[..];
    let public_key_hash =  keccak(&puk_uncompressed[1..]);
    let address_str = hex::encode(&public_key_hash[12..]);
    let puk_str = hex::encode(&public_key.serialize()[..]);
    Ok((format!("0x{}", address_str),format!("0x{}", puk_str)))
}

#[derive(Clone, Debug, PartialEq)]
pub struct EthTxHelper {
    abi: Contract,
}

impl EthTxHelper {
    fn load(abi_data: &[u8]) -> Self {
        let abi = ethabi::Contract::load(&abi_data[..]).expect("input data format not correct!");
        EthTxHelper {
            abi,
        }
    }

    fn encode_contract_input<P>(&self, method: &str, params: P) -> Result<Vec<u8>, error::Error> where P: contract::tokens::Tokenize {
        let data = self.abi.function(method).and_then(|function| {
            function.encode_input(&params.into_tokens())
        })?;
        Ok(data)
    }
}
pub fn get_erc20_transfer_data(address:H160,value:U256)->Result<Vec<u8>,error::Error>{
    let bytecode = include_bytes!("build/Erc20.abi");
    let helper = EthTxHelper::load(&bytecode[..]);
    helper.encode_contract_input("transfer", (address, value))
}

/// Description of a Transaction, pending or in the chain.
#[derive(Debug, Default, Clone, PartialEq, Deserialize, Serialize)]
pub struct RawTransaction {
    /// Nonce
    pub nonce: U256,
    /// Recipient (None when contract creation)
    pub to: Option<H160>,
    /// Transfered value
    pub value: U256,
    /// Gas Price
    #[serde(rename = "gasPrice")]
    pub gas_price: U256,
    /// Gas amount
    pub gas: U256,
    /// Input data
    pub data: Vec<u8>,
}

impl RawTransaction {
    pub fn sign(&self, private_key: &[u8], chain_id: Option<u64>) -> Vec<u8> {
        let hash_data = self.hash(chain_id);
        let sig = ecdsa_sign(&hash_data, private_key, chain_id.unwrap());
        let mut r_n = sig.r;
        let mut s_n = sig.s;
        while r_n[0] == 0 {
            r_n.remove(0);
        }
        while s_n[0] == 0 {
            s_n.remove(0);
        }
        let mut tx = RlpStream::new();
        tx.begin_unbounded_list();
        self.encode(&mut tx);
        tx.append(&sig.v);
        tx.append(&r_n);
        tx.append(&s_n);
        tx.finalize_unbounded_list();
        tx.out()
    }

    /// Signs and returns the RLP-encoded transaction
    fn hash(&self, chain_id: Option<u64>) -> [u8; 32] {
        let mut stream = RlpStream::new();
        stream.begin_unbounded_list();
        self.encode(&mut stream);
        if let Some(n) = chain_id {
            stream.append(&n);
            stream.append(&U256::zero());
            stream.append(&U256::zero());
        }
        stream.finalize_unbounded_list();
        keccak(stream.out().as_slice())
    }

    //对RawTransaction 数据使用RLP编码
    fn encode(&self, rlp: &mut RlpStream) {
        rlp.append(&self.nonce);
        rlp.append(&self.gas_price);
        rlp.append(&self.gas);
        if let Some(ref t) = self.to {
            rlp.append(t);
        } else {
            rlp.append(&vec![]);
        }
        rlp.append(&self.value);
        rlp.append(&self.data);
    }
}

 fn keccak(s: &[u8]) -> [u8; 32] {
    let mut result = [0u8; 32];
    tiny_keccak::Keccak::keccak256(s, &mut result);
    result
}

pub struct EcdsaSig {
    v: u64,
    r: Vec<u8>,
    s: Vec<u8>,
}

fn ecdsa_sign(hash: &[u8], private_key: &[u8], chain_id: u64) -> EcdsaSig {
    let s = Secp256k1::signing_only();
    let msg = Message::from_slice(hash).unwrap();
    let key = SecretKey::from_slice(private_key).unwrap();
    let (v, sig_bytes) = s.sign_recoverable(&msg, &key).serialize_compact();

    EcdsaSig {
        v: v.to_i32() as u64 + chain_id * 2 + 35,
        r: sig_bytes[0..32].to_vec(),
        s: sig_bytes[32..64].to_vec(),
    }
}
//根据精度，将字符串输入的数量转换为最小进度来表示
pub fn convert_token(value:&str,decimal:usize)->Option<U256>{
    //判断需要转化的数是否为浮点数
    match value.find(".") {
        Some(index) => {
            let integer_part = value.get(0..index).unwrap();
            let integer_part_256 = U256::from_dec_str(integer_part).unwrap();
            let integer_part_wei = integer_part_256.checked_mul(U256::exp10(decimal)).unwrap();
            //获取小数部分，只保留指定精度部分数据
            let max_distace = if value.len()-index<=decimal{
                value.len()
            }else {
                index+1+decimal
            };
            let decimal_part = value.get((index + 1)..max_distace).unwrap();
            let decimal_part_256 = U256::from_dec_str(decimal_part).unwrap();
            //将小数点去掉后，还需要在末尾添加0的个数
            let base = U256::exp10(decimal-decimal_part.len());
            let decimal_part_wei = decimal_part_256.checked_mul(base).unwrap();
            integer_part_wei.checked_add(decimal_part_wei)
        },
        None => {
            let integer_part = U256::from_dec_str(value).unwrap();
            let integer_part_wei = integer_part.checked_mul(U256::exp10(decimal));
            integer_part_wei
        }
    }
}

pub fn address_legal(address:&str) ->bool{
    let address= address.trim().to_lowercase();
    if address.is_empty()||!address.starts_with("0x")||address.len()!=42 {
        return false;
    }
    let chars = address.get(2..).unwrap().chars();
    for c in chars {

        if !(('a'<=c&&c<='z')||('0'<=c&&c<='9')){
            log::error!("illegal {}",c);
            return false;
        }
    }
    true
}

#[derive(Debug, Default, Clone, PartialEq, Deserialize, Serialize)]
struct ContractFunc{
    func_name:String,
    address:String,
    value:String,
    addition:String,//附加信息

}
//将目前只解析erc20 transfer 方法
pub fn decode_tranfer_data(input:&str)->Result<String,error::Error>{
    if !input.starts_with("0x"){
        return Err(error::Error::Decoder("data format error".to_string()));
    }
    //0xa9059cbb 为transfer前缀
    //当前只解析附加数据
    let addition = if input.starts_with("0xa9059cbb") {
        let start_len = 2+8;
        input.get(start_len+64*2..).unwrap()
    }else {
        input.get(2..).unwrap()
    };
    let data = hex::decode(addition)?;
   Ok(String::from_utf8(data)?)
  /*  match hex::decode(addition){
        Ok(data)=>String::from_utf8(data).map_err(|err| err.to_string()),
        Err(err)=>Ok(err.to_string())
    }*/

    //判断是否为普通data
/*    if input.starts_with("0xa9059cbb") {
        //满足这种情况的，认为是合约参数
        let start_len = 2+8;
        let addr = input.get((start_len+24)..start_len+64).unwrap();
        let value = {
            let value_bytes= hex::decode(input.get(start_len+64..start_len+64*2).unwrap()).unwrap();
            println!("value_bytes:{:?}",value_bytes);
            //大端?
            let value_u256 = U256::from_big_endian(&value_bytes);
            format!("{}",value_u256)
        };
        let func = ContractFunc{
            func_name:"transfer".to_string(),
            address:format!("0x{}",addr),
            value,
        };
        Ok(serde_json::to_string(&func).unwrap())
    }else {
        match hex::decode(input){
            Ok(data)=>String::from_utf8(data).map_err(|err| err.to_string()),
            Err(data)=>Ok(input.to_string())
        }
    }*/

}


#[test]
fn pri_from_mnemonic_test() {
    let words = "pulp second side simple clinic step salad enact only mixed address paddle";
    pri_from_mnemonic(words,None);
}

#[test]
fn erc20_transfer_data_test() {
    let address = H160::from_slice(hex::decode("5A0b54D5dc17e0AadC383d2db43B0a0D3E029c4c").unwrap().as_slice());
    let value = U256::from_dec_str("2000").unwrap();
    match get_erc20_transfer_data(address,value){
        Ok(data)=>{
            assert_eq!("a9059cbb0000000000000000000000005a0b54d5dc17e0aadc383d2db43b0a0d3e029c4c00000000000000000000000000000000000000000000000000000000000007d0".to_string(),hex::encode(data));
        },
        Err(e)=>log::error!("{}",e.to_string())
    }
}

#[test]
fn decode_tranfer_data_test(){
    let ret = decode_tranfer_data("0xa9059cbb000000000000000000000000c0c4824527ffb27a51034cea1e37840ed69a5f1e00000000000000000000000000000000000000000000000000000000000a2d77646464");
    assert_eq!(Ok("ddd".to_string()),ret);
}

#[test]
fn eth_rawtx_sign_test(){
    let contract_srt = "6080604052600436106101c15763ffffffff7c010000000000000000000000000000000000000000000000000000000060003504166302f652a381146101c657806305d2035b146101ee57806306fdde0314610217578063095ea7b3146102a157806318160ddd146102c55780631f3bec3b146102ec57806323b872dd1461031d57806329ff4f5314610347578063313ce5671461036857806340c10f191461039357806345977d03146103b75780635de4ccb0146103cf5780635f412d4f146103e4578063600440cb146103f9578063642b4a4d1461040e578063661884631461042357806370a0823114610447578063715018a6146104685780637d64bcb41461047d5780638444b39114610492578063867c2857146104cb5780638da5cb5b146104ec57806395d89b411461050157806396132521146105165780639738968c1461052b578063a9059cbb14610540578063adf403ad14610564578063ae1616b014610579578063c752ff621461058e578063d1f276d3146105a3578063d73dd623146105b8578063d7e7088a146105dc578063dd62ed3e146105fd578063dd681e5114610624578063f2fde38b14610639578063ffeb7d751461065a575b600080fd5b3480156101d257600080fd5b506101ec600160a060020a0360043516602435151561067b565b005b3480156101fa57600080fd5b50610203610770565b604080519115158252519081900360200190f35b34801561022357600080fd5b5061022c610779565b6040805160208082528351818301528351919283929083019185019080838360005b8381101561026657818101518382015260200161024e565b50505050905090810190601f1680156102935780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156102ad57600080fd5b50610203600160a060020a0360043516602435610807565b3480156102d157600080fd5b506102da61086e565b60408051918252519081900360200190f35b3480156102f857600080fd5b506103016108b2565b60408051600160a060020a039092168252519081900360200190f35b34801561032957600080fd5b50610203600160a060020a03600435811690602435166044356108c6565b34801561035357600080fd5b506101ec600160a060020a03600435166109d7565b34801561037457600080fd5b5061037d610ad0565b6040805160ff9092168252519081900360200190f35b34801561039f57600080fd5b50610203600160a060020a0360043516602435610ad9565b3480156103c357600080fd5b506101ec600435610bdc565b3480156103db57600080fd5b50610301610e18565b3480156103f057600080fd5b506101ec610e27565b34801561040557600080fd5b50610301610eb4565b34801561041a57600080fd5b50610301610ec8565b34801561042f57600080fd5b50610203600160a060020a0360043516602435610ed7565b34801561045357600080fd5b506102da600160a060020a0360043516610fc6565b34801561047457600080fd5b506101ec610fe1565b34801561048957600080fd5b5061020361104f565b34801561049e57600080fd5b506104a76110b5565b604051808260038111156104b757fe5b60ff16815260200191505060405180910390f35b3480156104d757600080fd5b50610203600160a060020a03600435166110ef565b3480156104f857600080fd5b50610301611104565b34801561050d57600080fd5b5061022c611113565b34801561052257600080fd5b5061020361116e565b34801561053757600080fd5b5061020361117e565b34801561054c57600080fd5b50610203600160a060020a036004351660243561119d565b34801561057057600080fd5b506103016112ac565b34801561058557600080fd5b506103016112bb565b34801561059a57600080fd5b506102da6112ca565b3480156105af57600080fd5b506103016112d0565b3480156105c457600080fd5b50610203600160a060020a03600435166024356112df565b3480156105e857600080fd5b506101ec600160a060020a0360043516611378565b34801561060957600080fd5b506102da600160a060020a0360043581169060243516611941565b34801561063057600080fd5b5061030161196c565b34801561064557600080fd5b506101ec600160a060020a036004351661197b565b34801561066657600080fd5b506101ec600160a060020a036004351661199e565b600354600160a060020a0316331461069257600080fd5b60045460009060a060020a900460ff1615610744576040805160e560020a62461bcd028152602060048201526044602482018190527f4974277320726571756972656420746861742074686520737461746520746f20908201527f636865636b20616c69676e732077697468207468652072656c6561736564206660648201527f6c61672e00000000000000000000000000000000000000000000000000000000608482015290519081900360a40190fd5b50600160a060020a03919091166000908152600560205260409020805460ff1916911515919091179055565b60065460ff1681565b600a805460408051602060026001851615610100026000190190941693909304601f810184900484028201840190925281815292918301828280156107ff5780601f106107d4576101008083540402835291602001916107ff565b820191906000526020600020905b8154815290600101906020018083116107e257829003601f168201915b505050505081565b336000818152600260209081526040808320600160a060020a038716808552908352818420869055815186815291519394909390927f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925928290030190a35060015b92915050565b600080805260208190527fad3228b676f7d3cd4284a5443f17f1962b36e491b30a40b2405849e597ba5fb5546001546108ac9163ffffffff611b2016565b90505b90565b600c546101009004600160a060020a031681565b600454600090849060a060020a900460ff16806108fb5750600160a060020a03811660009081526005602052604090205460ff165b15156109c3576040805160e560020a62461bcd02815260206004820152607f60248201527f466f722074686520746f6b656e20746f2062652061626c6520746f207472616e60448201527f736665723a20697427732072657175697265642074686174207468652063726f60648201527f776473616c6520697320696e2072656c65617365642073746174653b206f722060848201527f7468652073656e6465722069732061207472616e73666572206167656e742e0060a482015290519081900360c40190fd5b6109ce858585611b32565b95945050505050565b600354600160a060020a031633146109ee57600080fd5b60045460009060a060020a900460ff1615610aa0576040805160e560020a62461bcd028152602060048201526044602482018190527f4974277320726571756972656420746861742074686520737461746520746f20908201527f636865636b20616c69676e732077697468207468652072656c6561736564206660648201527f6c61672e00000000000000000000000000000000000000000000000000000000608482015290519081900360a40190fd5b506004805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a0392909216919091179055565b600c5460ff1681565b600354600090600160a060020a03163314610af357600080fd5b60065460ff1615610b0357600080fd5b600154610b16908363ffffffff611ca716565b600155600160a060020a038316600090815260208190526040902054610b42908363ffffffff611ca716565b600160a060020a03841660008181526020818152604091829020939093558051858152905191927f0f6798a560793a54c3bcfe86a93cde1e73087d944c0ea20544137d412139688592918290030190a2604080518381529051600160a060020a038516916000917fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9181900360200190a350600192915050565b6000610be66110b5565b90506003816003811115610bf657fe5b14610c71576040805160e560020a62461bcd02815260206004820152602e60248201527f497427732072657175697265642074686174207468652075706772616465207360448201527f746174652069732072656164792e000000000000000000000000000000000000606482015290519081900360840190fd5b60008211610cef576040805160e560020a62461bcd02815260206004820152602c60248201527f54686520757067726164652076616c756520697320726571756972656420746f60448201527f2062652061626f766520302e0000000000000000000000000000000000000000606482015290519081900360840190fd5b33600090815260208190526040902054610d0f908363ffffffff611b2016565b33600090815260208190526040902055600154610d32908363ffffffff611b2016565b600155600854610d48908363ffffffff611ca716565b600855600754604080517f753e88e5000000000000000000000000000000000000000000000000000000008152336004820152602481018590529051600160a060020a039092169163753e88e59160448082019260009290919082900301818387803b158015610db757600080fd5b505af1158015610dcb573d6000803e3d6000fd5b5050600754604080518681529051600160a060020a0390921693503392507f7e5c344a8141a805725cb476f76c6953b842222b967edd1f78ddb6e8b3f397ac919081900360200190a35050565b600754600160a060020a031681565b600454600160a060020a03163314610e9d576040805160e560020a62461bcd0281526020600482015260316024820152600080516020611f8583398151915260448201527f20612072656c65617365206167656e742e000000000000000000000000000000606482015290519081900360840190fd5b6006805460ff19166001179055610eb2611cb4565b565b6006546101009004600160a060020a031681565b600d54600160a060020a031681565b336000908152600260209081526040808320600160a060020a0386168452909152812054808310610f2b57336000908152600260209081526040808320600160a060020a0388168452909152812055610f60565b610f3b818463ffffffff611b2016565b336000908152600260209081526040808320600160a060020a03891684529091529020555b336000818152600260209081526040808320600160a060020a0389168085529083529281902054815190815290519293927f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925929181900390910190a35060019392505050565b600160a060020a031660009081526020819052604090205490565b600354600160a060020a03163314610ff857600080fd5b600354604051600160a060020a03909116907ff8df31144d9c2f0f6b59d69b8b98abd5459d07f2742c4df920b25aae33c6482090600090a26003805473ffffffffffffffffffffffffffffffffffffffff19169055565b600354600090600160a060020a0316331461106957600080fd5b60065460ff161561107957600080fd5b6006805460ff191660011790556040517fae5184fba832cb2b1f702aca6117b8d265eaf03ad33eb133f19dde0f5920fa0890600090a150600190565b60006110bf61117e565b15156110cd575060016108af565b600754600160a060020a031615156110e7575060026108af565b5060036108af565b60056020526000908152604090205460ff1681565b600354600160a060020a031681565b600b805460408051602060026001851615610100026000190190941693909304601f810184900484028201840190925281815292918301828280156107ff5780601f106107d4576101008083540402835291602001916107ff565b60045460a060020a900460ff1681565b60045460009060a060020a900460ff1680156108ac57506108ac611d50565b600454600090339060a060020a900460ff16806111d25750600160a060020a03811660009081526005602052604090205460ff165b151561129a576040805160e560020a62461bcd02815260206004820152607f60248201527f466f722074686520746f6b656e20746f2062652061626c6520746f207472616e60448201527f736665723a20697427732072657175697265642074686174207468652063726f60648201527f776473616c6520697320696e2072656c65617365642073746174653b206f722060848201527f7468652073656e6465722069732061207472616e73666572206167656e742e0060a482015290519081900360c40190fd5b6112a48484611d59565b949350505050565b600e54600160a060020a031681565b601054600160a060020a031681565b60085481565b600454600160a060020a031681565b336000908152600260209081526040808320600160a060020a0386168452909152812054611313908363ffffffff611ca716565b336000818152600260209081526040808320600160a060020a0389168085529083529281902085905580519485525191937f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925929081900390910190a350600192915050565b61138061117e565b1515611422576040805160e560020a62461bcd02815260206004820152604960248201527f4974277320726571756972656420746f20626520696e2063616e55706772616460448201527f65282920636f6e646974696f6e207768656e2073657474696e6720757067726160648201527f6465206167656e742e0000000000000000000000000000000000000000000000608482015290519081900360a40190fd5b600160a060020a03811615156114ce576040805160e560020a62461bcd02815260206004820152604860248201527f4167656e7420697320726571756972656420746f20626520616e206e6f6e2d6560448201527f6d7074792061646472657373207768656e2073657474696e672075706772616460648201527f65206167656e742e000000000000000000000000000000000000000000000000608482015290519081900360a40190fd5b6006546101009004600160a060020a0316331461156f576040805160e560020a62461bcd02815260206004820152604e6024820152600080516020611f8583398151915260448201527f2074686520757067726164654d6173746572207768656e2073657474696e672060648201527f75706772616465206167656e742e000000000000000000000000000000000000608482015290519081900360a40190fd5b60036115796110b5565b600381111561158457fe5b1415611626576040805160e560020a62461bcd02815260206004820152604960248201527f5570677261646520737461746520697320726571756972656420746f206e6f7460448201527f20626520757067726164696e67207768656e2073657474696e6720757067726160648201527f6465206167656e742e0000000000000000000000000000000000000000000000608482015290519081900360a40190fd5b600754600160a060020a0316156116ad576040805160e560020a62461bcd02815260206004820152602660248201527f757067726164654167656e74206f6e6365207365742c2063616e6e6f7420626560448201527f2072657365740000000000000000000000000000000000000000000000000000606482015290519081900360840190fd5b6007805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a038381169190911791829055604080517f61d3d7a6000000000000000000000000000000000000000000000000000000008152905192909116916361d3d7a6916004808201926020929091908290030181600087803b15801561173157600080fd5b505af1158015611745573d6000803e3d6000fd5b505050506040513d602081101561175b57600080fd5b50511515611825576040805160e560020a62461bcd02815260206004820152607e60248201527f5468652070726f7669646564207570646174654167656e7420636f6e7472616360448201527f7420697320726571756972656420746f20626520636f6d706c69616e7420746f60648201527f2074686520557067726164654167656e7420696e74657266616365206d65746860848201527f6f64207768656e2073657474696e672075706772616465206167656e742e000060a482015290519081900360c40190fd5b600154600760009054906101000a9004600160a060020a0316600160a060020a0316634b2ba0dd6040518163ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401602060405180830381600087803b15801561189457600080fd5b505af11580156118a8573d6000803e3d6000fd5b505050506040513d60208110156118be57600080fd5b5051146118ff5760405160e560020a62461bcd028152600401808060200182810382526090815260200180611ef56090913960a00191505060405180910390fd5b60075460408051600160a060020a039092168252517f7845d5aa74cc410e35571258d954f23b82276e160fe8c188fa80566580f279cc9181900360200190a150565b600160a060020a03918216600090815260026020908152604080832093909416825291909152205490565b600f54600160a060020a031681565b600354600160a060020a0316331461199257600080fd5b61199b81611e38565b50565b600160a060020a0381161515611a4a576040805160e560020a62461bcd02815260206004820152605d60248201527f5468652070726f766964656420757067726164654d617374657220697320726560448201527f71756972656420746f2062652061206e6f6e2d656d707479206164647265737360648201527f207768656e2073657474696e672075706772616465206d61737465722e000000608482015290519081900360a40190fd5b6006546101009004600160a060020a03163314611aeb576040805160e560020a62461bcd02815260206004820152605e6024820152600080516020611f8583398151915260448201527f20746865206f726967696e616c20757067726164654d6173746572207768656e60648201527f2073657474696e6720286e6577292075706772616465206d61737465722e0000608482015290519081900360a40190fd5b60068054600160a060020a039092166101000274ffffffffffffffffffffffffffffffffffffffff0019909216919091179055565b600082821115611b2c57fe5b50900390565b600160a060020a038316600090815260208190526040812054821115611b5757600080fd5b600160a060020a0384166000908152600260209081526040808320338452909152902054821115611b8757600080fd5b600160a060020a0383161515611b9c57600080fd5b600160a060020a038416600090815260208190526040902054611bc5908363ffffffff611b2016565b600160a060020a038086166000908152602081905260408082209390935590851681522054611bfa908363ffffffff611ca716565b600160a060020a03808516600090815260208181526040808320949094559187168152600282528281203382529091522054611c3c908363ffffffff611b2016565b600160a060020a03808616600081815260026020908152604080832033845282529182902094909455805186815290519287169391927fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef929181900390910190a35060019392505050565b8181018281101561086857fe5b600454600160a060020a03163314611d2a576040805160e560020a62461bcd0281526020600482015260316024820152600080516020611f8583398151915260448201527f20612072656c65617365206167656e742e000000000000000000000000000000606482015290519081900360840190fd5b6004805474ff0000000000000000000000000000000000000000191660a060020a179055565b60095460ff1690565b33600090815260208190526040812054821115611d7557600080fd5b600160a060020a0383161515611d8a57600080fd5b33600090815260208190526040902054611daa908363ffffffff611b2016565b3360009081526020819052604080822092909255600160a060020a03851681522054611ddc908363ffffffff611ca716565b600160a060020a038416600081815260208181526040918290209390935580518581529051919233927fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9281900390910190a350600192915050565b600160a060020a0381161515611e4d57600080fd5b600354604051600160a060020a038084169216907f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e090600090a36003805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a0392909216919091179055565b6000821515611ec757506000610868565b50818102818382811515611ed757fe5b041461086857fe5b60008183811515611eec57fe5b04939250505056005468652070726f766964656420757067726164654167656e7420636f6e74726163742773206f726967696e616c537570706c7920697320726571756972656420746f206265206571756976616c656e7420746f206578697374696e6720636f6e7472616374277320746f74616c537570706c795f207768656e2073657474696e672075706772616465206167656e742e4d6573736167652073656e64657220697320726571756972656420746f206265a165627a7a72305820b1e04321bb9e830b1d8318c500afb2b83bdfb0cdeed898227da51bf1bbc414670029";
    let contract_byte = hex::decode(contract_srt).unwrap();
    let json = r#" {
            "nonce": "0x06",
            "gasPrice": "0x4a817c800",
            "gas": "0x7a1200",
            "to": "0x1c9baedc94600b2d1c8a6d2bad1744e6182f300e",
            "value": "0xde0b6b3a7640000",
            "data": []
        }"#;
    let chain_id = Some(17);
    let mut rawtx : RawTransaction = serde_json::from_str(json).expect("tx format");
    let addition ="tx test";
    //rawtx.data = addition.as_bytes().to_vec();
   // rawtx.data = contract_byte;
   // rawtx.to = None;
    let words = "pulp second side simple clinic step salad enact only mixed address paddle";
    let pri_from_mn = pri_from_mnemonic(words,None).unwrap();
    assert_eq!("c6e2fcde7a2713e20cb92f23e11f6d7ac5601124d38ba0eea3bf538a030c9365".to_string(),hex::encode(pri_from_mn));
    let pri = "4d5db4107d237df6a3d58ee5f70ae63d73d7658d4026f2eefd2f204c81682cb7";
    let signed_data = rawtx.sign(&hex::decode(pri).unwrap(),chain_id);
    assert_eq!("f86d068504a817c800837a1200941c9baedc94600b2d1c8a6d2bad1744e6182f300e880de0b6b3a76400008046a07e2c71664464b95fab4b1706785c244d86cef96b5e5c186a314c63306cfe9c54a0637c605b6004bb244cbea9bc69e18b7bd18b491c3794e17e31a0c932592bb476".to_string(),hex::encode(signed_data))
}



#[test]
fn dec_prase_test() {
    assert_eq!( U256::from_dec_str("123000000000000000000").ok(), convert_token("123", 18));
    assert_eq!( U256::from_dec_str("123123456789000000000").ok(), convert_token("123.123456789", 18));
    assert_eq!(U256::from_dec_str("123012345678901234567").ok(), convert_token("123.012345678901234567", 18));
    assert_eq!(U256::from_dec_str("123012345678901234567").ok(), convert_token("123.01234567890123456789", 18));
}

#[test]
fn address_format_legal_test(){
    assert_eq!(false, address_legal("1b5b5f3c5d"));
    assert_eq!(true, address_legal("0x72f901b5b5f3c5d599bfcdda667b5b4716e3c46c"));
    assert_eq!(true, address_legal("0x7+f901b5b5f3c5d599bfcdda667b5b4716e3c46c"));
}


