use async_trait::async_trait;
use rbatis::crud::CRUDEnable;

use mav::{ChainType, NetType, WalletType};
use mav::kits::sql_left_join_get_b;
use mav::ma::{Dao, MEthChainToken, MEthChainTokenAuth, MEthChainTokenDefault, MEthChainTokenShared, MWallet};

use crate::{Chain2WalletType, ChainShared, ContextTrait, deref_type, Load, WalletError};

#[derive(Debug, Default)]
pub struct EthChainToken {
    pub m: MEthChainToken,
    pub eth_chain_token_shared: EthChainTokenShared,
}
deref_type!(EthChainToken,MEthChainToken);

#[async_trait]
impl Load for EthChainToken {
    type MType = MEthChainToken;
    async fn load(&mut self, context: &dyn ContextTrait, m: Self::MType) -> Result<(), WalletError> {
        self.m = m;
        let rb = context.db().wallets_db();
        let token_shared = MEthChainTokenShared::fetch_by_id(rb, "", &self.m.chain_token_shared_id).await?;
        let token_shared = token_shared.ok_or_else(||
            WalletError::NoneError(format!("do not find id:{}, in {}", &self.chain_token_shared_id, MEthChainTokenShared::table_name())))?;
        self.eth_chain_token_shared.load(context, token_shared).await?;
        Ok(())
    }
}

#[derive(Debug, Default)]
pub struct EthChainTokenShared {
    pub m: MEthChainTokenShared,
    //  pub token_shared: TokenShared,
}
deref_type!(EthChainTokenShared,MEthChainTokenShared);

impl From<MEthChainTokenShared> for EthChainTokenShared {
    fn from(token_shared: MEthChainTokenShared) -> Self {
        Self {
            m: token_shared,
        }
    }
}

#[async_trait]
impl Load for EthChainTokenShared {
    type MType = MEthChainTokenShared;
    async fn load(&mut self, _: &dyn ContextTrait, m: Self::MType) -> Result<(), WalletError> {
        self.m = m;
        //self.token_shared.m = self.m.token_shared.clone();
        Ok(())
    }
}

#[derive(Debug, Default)]
pub struct EthChainTokenDefault {
    pub m: MEthChainTokenDefault,
    pub eth_chain_token_shared: EthChainTokenShared,
}
deref_type!(EthChainTokenDefault,MEthChainTokenDefault);

impl EthChainTokenDefault {
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType) -> Result<Vec<EthChainTokenDefault>, WalletError> {
        let tx_id = "";
        let wallets_db = context.db().wallets_db();
        let tokens_shared: Vec<MEthChainTokenShared> = {
            let default_name = MEthChainTokenDefault::table_name();
            let shared_name = MEthChainTokenShared::table_name();
            let wrapper = wallets_db.new_wrapper().eq(format!("{}.{}", default_name, MEthChainTokenDefault::net_type).as_str(), net_type.to_string());

            let sql = {
                let t = sql_left_join_get_b(&default_name, &MEthChainTokenDefault::chain_token_shared_id,
                                            &shared_name, &MEthChainTokenShared::id);
                format!("{} where {}", t, &wrapper.sql)
            };
            wallets_db.fetch_prepare(tx_id, &sql, &wrapper.args).await?
        };
        let mut tokens_default = {
            let wrapper = wallets_db.new_wrapper()
                .eq(MEthChainTokenDefault::net_type, net_type.to_string())
                .order_by(true, &[MEthChainTokenDefault::position]);
            MEthChainTokenDefault::list_by_wrapper(wallets_db, tx_id, &wrapper).await?
        };
        for token_default in &mut tokens_default {
            for token_shared in &tokens_shared {
                if token_default.chain_token_shared_id == token_shared.id {
                    token_default.chain_token_shared = token_shared.clone();
                }
            }
        }
     let eth_tokens = tokens_default.iter().map(|token|EthChainTokenDefault{
            m: token.clone(),
            eth_chain_token_shared: EthChainTokenShared::from(token.chain_token_shared.clone())
        }).collect::<Vec<EthChainTokenDefault>>();
        Ok(eth_tokens)
    }
}


#[derive(Debug, Default)]
pub struct EthChainTokenAuth {
    pub m: MEthChainTokenAuth,
    pub eth_chain_token_shared: EthChainTokenShared,
}
deref_type!(EthChainTokenAuth,MEthChainTokenAuth);


impl EthChainTokenAuth {
    pub async fn list_by_net_type(context: &dyn ContextTrait, net_type: &NetType, start_item: u64, page_size: u64) -> Result<Vec<EthChainTokenAuth>, WalletError> {
        let tx_id = "";
        let wallets_db = context.db().wallets_db();
        let page_query = format!(" limit {} offset {}", page_size, start_item);
        let mut tokens_auth = {
            let wrapper = wallets_db.new_wrapper()
                .eq(MEthChainTokenAuth::net_type, net_type.to_string())
                .order_by(false, &[MEthChainTokenAuth::create_time]).push_sql(&page_query);
            MEthChainTokenAuth::list_by_wrapper(wallets_db, tx_id, &wrapper).await?
        };
        let token_shared_id = format!("id in (SELECT {} FROM {} WHERE {}='{}' ORDER by {} desc {})",
                                      MEthChainTokenAuth::chain_token_shared_id, MEthChainTokenAuth::table_name(), MEthChainTokenAuth::net_type, net_type.to_string(), MEthChainTokenAuth::create_time, page_query);
        let token_shared_wrapper = wallets_db.new_wrapper().push_sql(&token_shared_id);
        let tokens_shared = MEthChainTokenShared::list_by_wrapper(wallets_db, tx_id, &token_shared_wrapper).await?;
        let mut target_tokens = vec![];
        for token_auth in &mut tokens_auth {
            for token_shared in &tokens_shared {
                let mut token = EthChainTokenAuth::default();
                if token_auth.chain_token_shared_id == token_shared.id {
                    token.m = token_auth.clone();
                    token.eth_chain_token_shared = EthChainTokenShared::from(token_shared.clone());
                    target_tokens.push(token)
                }
            }
        }
        Ok(target_tokens)
    }
}

#[derive(Debug, Default)]
pub struct EthChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<EthChainToken>,
}

impl Chain2WalletType for EthChain {
    fn chain_type(wallet_type: &WalletType) -> ChainType {
        match wallet_type {
            WalletType::Normal => ChainType::ETH,
            _ => ChainType::EthTest,
        }
    }

    fn to_chain_type(&self, wallet_type: &WalletType) -> ChainType {
        EthChain::chain_type(wallet_type)
    }
}

#[async_trait]
impl Load for EthChain {
    type MType = MWallet;

    async fn load(&mut self, context: &dyn ContextTrait, mw: Self::MType) -> Result<(), WalletError> {
        self.chain_shared.set_m(&mw);
        let wallet_type = WalletType::from(mw.wallet_type.as_str());
        self.chain_shared.m.chain_type = self.to_chain_type(&wallet_type).to_string();

        {//load address
            let wallet_id = self.chain_shared.wallet_id.clone();
            let chain_type = self.chain_shared.chain_type.clone();
            self.chain_shared.set_addr(context, &wallet_id, &chain_type).await?;
        }
        {//load token

            let rb = context.db().data_db(&NetType::from(&mw.net_type));
            let wrapper = rb.new_wrapper()
                .eq(MEthChainToken::wallet_id, mw.id.clone())
                .eq(MEthChainToken::chain_type, self.chain_shared.chain_type.clone());
            let ms = MEthChainToken::list_by_wrapper(&rb, "", &wrapper).await?;
            self.tokens.clear();
            for it in ms {
                let mut token = EthChainToken::default();
                token.load(context, it).await?;
                self.tokens.push(token);
            }
        }

        Ok(())
    }
}

#[cfg(test)]
mod tests {
    use mav::{ChainType, WalletType};

    use crate::{Chain2WalletType, EthChain};

    #[test]
    fn eth_chain_test() {
        let t = EthChain::chain_type(&WalletType::Normal);
        assert_eq!(ChainType::ETH, t);
        let t = EthChain::chain_type(&WalletType::Test);
        assert_eq!(ChainType::EthTest, t);

        let t = EthChain::wallet_type(&ChainType::ETH);
        assert_eq!(WalletType::Normal, t);
        let t = EthChain::wallet_type(&ChainType::EthTest);
        assert_eq!(WalletType::Test, t);
    }
}
