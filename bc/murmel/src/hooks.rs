//！ hooks message for notices when should get data

use crate::p2p::PeerId;

pub enum HooksMessage {
    ReceivedHeaders(PeerId),
    Others,
}

pub enum ApiMessage {
    Api,
    Db,
    Other,
}
