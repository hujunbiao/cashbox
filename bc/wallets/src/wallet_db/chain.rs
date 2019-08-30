use crate::wallet_db::db_helper::DataServiceProvider;
use crate::model::TbWallet;

impl DataServiceProvider{

    pub fn display_eee_chain(&self) -> Result<Vec<TbWallet>, String> {
        let all_mn = "select c.mnemonic_id as wallet_id, b.id as chain_id,d.address,b.address as chain_address,b.type as chian_type,d.id as digit_id,d.contract_address,d.short_name,d.full_name,
d.balance,d.selected as isvisible,d.decimals,d.url_img from wallet.Chain b,wallet.Address c,wallet.EeeDigit d
where c.chain_id = b.id and c.address=d.address and  c.status =1 ORDER by c.mnemonic_id" ;

        let mut cursor = self.db_hander.prepare(all_mn).unwrap().cursor();
        let mut tbwallets = Vec::new();
        while let Some(row) = cursor.next().unwrap() {
            println!("query wallet_id {:?},wallet_name:{:?}", row[0].as_string(), row[1].as_string());
            let tbwallet = TbWallet {
                wallet_id: row[0].as_string().map(|str| String::from(str)),
                wallet_name: row[1].as_string().map(|str| String::from(str)),
                chain_id: row[2].as_integer(),
                address: row[3].as_string().map(|str| String::from(str)),
                chain_address: row[4].as_string().map(|str| String::from(str)),
                selected: row[5].as_integer().map(|num| if num == 1 { true } else { false }),
                chain_type: row[6].as_integer(),
                digit_id: row[7].as_integer(),
                contract_address: row[8].as_string().map(|str| String::from(str)),
                short_name: row[9].as_string().map(|str| String::from(str)),
                full_name: row[10].as_string().map(|str| String::from(str)),
                balance: row[11].as_string().map(|str| String::from(str)),
                isvisible: row[12].as_integer().map(|num| if num == 1 { true } else { false }),
                decimals: row[13].as_integer(),
                url_img: row[14].as_string().map(|str| String::from(str)),
            };
            tbwallets.push(tbwallet);
        }
        Ok(tbwallets)
    }

    pub fn display_eth_chain(&self) -> Result<Vec<TbWallet>, String> {
        let all_mn = "select a.id as wallet_id,a.fullname as wallet_name,b.id as chain_id,d.address,b.address as chain_address,a.selected,b.type as chian_type,d.id as digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.selected as isvisible,d.decimals,d.url_img
 from Mnemonic a,wallet.Chain b,wallet.Address c,wallet.EthDigit d where a.id=c.mnemonic_id and c.chain_id = b.id and c.address=d.address and a.status =1 and c.status =1;";

        let mut cursor = self.db_hander.prepare(all_mn).unwrap().cursor();
        let mut tbwallets = Vec::new();
        while let Some(row) = cursor.next().unwrap() {
            println!("query wallet_id {:?},wallet_name:{:?}", row[0].as_string(), row[1].as_string());
            let tbwallet = TbWallet {
                wallet_id: row[0].as_string().map(|str| String::from(str)),
                wallet_name: row[1].as_string().map(|str| String::from(str)),
                chain_id: row[2].as_integer(),
                address: row[3].as_string().map(|str| String::from(str)),
                chain_address: row[4].as_string().map(|str| String::from(str)),
                selected: row[5].as_integer().map(|num| if num == 1 { true } else { false }),
                chain_type: row[6].as_integer(),
                digit_id: row[7].as_integer(),
                contract_address: row[8].as_string().map(|str| String::from(str)),
                short_name: row[9].as_string().map(|str| String::from(str)),
                full_name: row[10].as_string().map(|str| String::from(str)),
                balance: row[11].as_string().map(|str| String::from(str)),
                isvisible: row[12].as_integer().map(|num| if num == 1 { true } else { false }),
                decimals: row[13].as_integer(),
                url_img: row[14].as_string().map(|str| String::from(str)),
            };
            tbwallets.push(tbwallet);
        }
        Ok(tbwallets)
    }

    pub fn display_btc_chain(&self) -> Result<Vec<TbWallet>, String> {
        let all_mn = "select a.id as wallet_id,a.fullname as wallet_name,b.id as chain_id,d.address,b.address as chain_address,a.selected,b.type as chian_type,d.id as digit_id,d.contract_address,d.short_name,d.full_name,d.balance,d.selected as isvisible,d.decimals,d.url_img
 from Mnemonic a,wallet.Chain b,wallet.Address c,wallet.BtcDigit d where a.id=c.mnemonic_id and c.chain_id = b.id and c.address=d.address and a.status =1 and c.status =1;";

        let mut cursor = self.db_hander.prepare(all_mn).unwrap().cursor();
        let mut tbwallets = Vec::new();
        while let Some(row) = cursor.next().unwrap() {
            println!("query wallet_id {:?},wallet_name:{:?}", row[0].as_string(), row[1].as_string());
            let tbwallet = TbWallet {
                wallet_id: row[0].as_string().map(|str| String::from(str)),
                wallet_name: row[1].as_string().map(|str| String::from(str)),
                chain_id: row[2].as_integer(),
                address: row[3].as_string().map(|str| String::from(str)),
                chain_address: row[4].as_string().map(|str| String::from(str)),
                selected: row[5].as_integer().map(|num| if num == 1 { true } else { false }),
                chain_type: row[6].as_integer(),
                digit_id: row[7].as_integer(),
                contract_address: row[8].as_string().map(|str| String::from(str)),
                short_name: row[9].as_string().map(|str| String::from(str)),
                full_name: row[10].as_string().map(|str| String::from(str)),
                balance: row[11].as_string().map(|str| String::from(str)),
                isvisible: row[12].as_integer().map(|num| if num == 1 { true } else { false }),
                decimals: row[13].as_integer(),
                url_img: row[14].as_string().map(|str| String::from(str)),
            };
            tbwallets.push(tbwallet);
        }
        Ok(tbwallets)
    }

}