//! mod for sqlite
//!
//!
use std::sync::{Arc, Mutex};
use sqlite::{State, Value, Statement};
use bitcoin::{Network, BitcoinHash};
use bitcoin::blockdata::constants::genesis_block;
use bitcoin::secp256k1::ecdh::SharedSecret;
use error;
use bitcoin::hashes::hex::ToHex;

pub type SharedSQLite = Arc<Mutex<SQLite>>;

pub struct SQLite {
    connection: sqlite::Connection,
    network: Network,
}

impl SQLite {
    pub fn open_db(network: Network) -> Self {
        let mut sqlite = sqlite::open("client_sqlite.sqlite").expect("create sqlite error");
        sqlite.set_busy_timeout(3000).unwrap();
        sqlite.execute(
            "
            CREATE TABLE IF NOT EXISTS block_hash(block_hash TEXT,scanned TEXT,timestamp TEXT);
            "
        ).expect("Create table block_hash error");
        sqlite.execute(
            "create table if not exists utxos(txhash TEXT,script TEXT, value REAL, vout INT);"
        ).expect("Create table tx error");
        sqlite.execute(
            "create table if not exists newest_hash(key TEXT,block_hash TEXT,timestamp TEXT);"
        ).expect("Create newest_hash table error");
        Self {
            connection: sqlite,
            network,
        }
    }

    /// 查询上次初始化进度
    pub fn init(&self) -> (String, String) {
        let (block_hash, timestamp) = self.query_newest_header(NEWEST_KEY);
        if block_hash.is_none() {
            let genesis = genesis_block(self.network).header;
            let block_hash = genesis.bitcoin_hash().to_hex();
            let timestamp = genesis.time.to_string();
            info!("scanned newest block from genesis {:?}", &block_hash);
            self.insert_newest_header(block_hash.clone(), timestamp.clone());
            return (block_hash.clone(), timestamp.clone());
        }

        let block_hash = block_hash.expect("No block");
        let timestamp = timestamp.expect("No timestamp");
        info!("scanned newest block from restored block {:?}", &block_hash);
        (block_hash, timestamp)
    }

    //存储区块头
    pub fn insert_block(&self, block_hash: String, timestamp: String) {
        let mut statement = self.connection.prepare(
            "INSERT INTO block_hash VALUES(?, ?, ?)"
        ).expect("PREPARE ERR");
        statement.bind(1, block_hash.as_str()).unwrap();
        statement.bind(2, "0").unwrap();
        statement.bind(3, timestamp.as_str()).unwrap();
        statement.next().expect("insert block error");
    }

    //查询未扫描区块头 返回相应数据 以时间戳为依据
    pub fn query_header(&self, timestamp: String) -> Vec<String> {
        let mut statement = self.connection.prepare(
            "SELECT * FROM block_hash WHERE timestamp >= ? AND  scanned <= 5 LIMIT 1000"
        ).expect("query_header PREPARE ERR");
        statement.bind(
            1,
            timestamp.as_str(),
        ).expect("bind ERR");
        let mut block_hashes = vec![];
        while let State::Row = statement.next().unwrap() {
            let block_hash = statement.read::<String>(0).unwrap();
            block_hashes.push(block_hash);
        }

        let mut statement2 = self.connection.prepare(
            "UPDATE block_hash SET scanned = scanned + 1 WHERE timestamp >= ? AND scanned <= 5 LIMIT 1000"
        ).expect("update scan ERR");
        statement2.bind(1, timestamp.as_str()).expect("bind ERR");
        statement2.next().expect("update scanned ERR");

        block_hashes
    }

    //查询最新进度s
    pub fn query_newest_header(&self, key: &str) -> (Option<String>, Option<String>) {
        let mut statement = self.connection.prepare(
            "SELECT * FROM newest_hash WHERE key = ?"
        ).expect("query_new error");
        statement.bind(1, key).expect("query newest error");
        while let State::Row = statement.next().unwrap() {
            let block_hash = statement.read::<String>(1).expect("query block hash error");
            let timestamp = statement.read::<String>(2).expect("query block hash error");
            return (Some(block_hash), Some(timestamp));
        }
        (None, None)
    }

    //插入最新进度
    pub fn insert_newest_header(&self, block_hash: String, timestamp: String) {
        let mut statement = self.connection.prepare(
            "INSERT INTO newest_hash VALUES(?, ?, ?)"
        ).expect("PREPARE ERR");
        statement.bind(1, NEWEST_KEY).unwrap();
        statement.bind(2, block_hash.as_str()).unwrap();
        statement.bind(3, timestamp.as_str()).unwrap();
        statement.next().expect("insert newest_header error");
    }

    //更新最新进度
    pub fn update_newest_header(&self, block_hash: String, timestamp: String) {
        let mut statement = self.connection.prepare(
            "UPDATE newest_hash SET block_hash = ?, timestamp = ? WHERE key = ?"
        ).expect("PREPARE ERR");
        statement.bind(1, block_hash.as_str()).unwrap();
        statement.bind(2, timestamp.as_str()).unwrap();
        statement.bind(3, NEWEST_KEY).unwrap();
        statement.next().expect("insert newest_header error");
    }

    //存储 utxo
    pub fn insert_utxo(&self, txhash: String, script: String, value: String, vout: i64) {
        let mut statement = self.connection.prepare(
            "INSERT INTO utxos VALUES(?,?,?,?)"
        ).expect("insert utxo error");
        statement.bind(1, txhash.as_str()).expect("bind statement error");
        statement.bind(2, script.as_str()).expect("bind statement error");
        statement.bind(3, value.as_str()).expect("bind statement error");
        statement.bind(4, vout).expect("bind statement error");
        statement.next().expect("insert utxos error");
    }
}

const NEWEST_KEY: &str = "NEWEST_KEY";

