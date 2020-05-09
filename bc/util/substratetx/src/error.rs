use derive_more::Display;
//todo 优化自定义 Error实现
#[derive(Debug, Display)]
pub enum Error {
    #[display(fmt = "Custom error: {}", _0)]
    Custom(String),
    #[display(fmt = "SecretString error: {:?}", _0)]
    SecretString(sp_core::crypto::SecretStringError),
    #[display(fmt = "crypto Public error: {:?}", _0)]
    Public(sp_core::crypto::PublicError),
    #[display(fmt = "substrate_bip39 error: {:?}", _0)]
    Bip39(substrate_bip39::Error),
    #[display(fmt = "hex FromHexError error: {:?}", _0)]
    HexError(hex::FromHexError),
    #[display(fmt = "serde json error: {:?}", _0)]
    Serde(serde_json::Error),
}

/*impl std::error::Error for Error {
    fn source(&self) -> Option<&(dyn std::error::Error + 'static)> {
        use self::Error::*;
        match *self {
            Custom(_)|HexError(_)|Serde(_) => None,
            Bip39(ref e)=> Some(e),
            Public(ref e)=> Some(e),
            SecretString(ref e)=> Some(e),
        }
    }
}*/

impl From<failure::Error> for Error{
    fn from(err: failure::Error)->Self{
        Error::Custom(format!("{:?}", err))
    }
}
impl From<substrate_bip39::Error> for Error{
    fn from(err: substrate_bip39::Error)->Self{
        Error::Bip39(err)
    }
}

impl From<sp_core::crypto::SecretStringError> for Error{
    fn from(err: sp_core::crypto::SecretStringError)->Self{
        Error::SecretString(err)
    }
}

impl  From<sp_core::crypto::PublicError> for Error {
    fn from(err: sp_core::crypto::PublicError) -> Self {
        Error::Public(err)
    }
}

impl  From<hex::FromHexError> for Error {
    fn from(err: hex::FromHexError) -> Self {
        Error::HexError(err)
    }
}

impl  From<serde_json::error::Error> for Error {
    fn from(err: serde_json::error::Error) -> Self {
        Error::Serde(err)
    }
}
