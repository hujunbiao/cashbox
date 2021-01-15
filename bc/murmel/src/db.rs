//! mod for sqlite
//! use two database
//!     1. for btc chain database
//!     2. for user data (utxo address ...)
//!
use crate::path::{BTC_CHAIN_PATH, BTC_DETAIL_PATH};
use async_trait::async_trait;
use bitcoin::blockdata::constants::genesis_block;
use bitcoin::hashes::hex::ToHex;
use bitcoin::{BitcoinHash, Network};
use futures::executor::block_on;
use log::{debug, info};
use mav::ma::{Dao, MBlockHeader};
use mav::ma::{MLocalTxLog, MProgress, MTxInput, MTxOutput, MUserAddress};
use once_cell::sync::Lazy;
use rbatis::crud::CRUD;
use rbatis::plugin::page::{IPage, Page, PageRequest};
use rbatis::rbatis::Rbatis;
use rbatis_core::Error;
use std::ops::Add;

pub struct ChainSqlite {
    rb: Rbatis,
    network: Network,
}

impl ChainSqlite {
    pub fn new(network: Network, db_file_name: &str) -> Self {
        let rb = block_on(Self::init_rbatis(db_file_name));
        let r = block_on(rb.exec("", MBlockHeader::create_table_script()));
        match r {
            Ok(a) => {
                info!("{:?}", a);
            }
            Err(e) => {
                info!("{:?}", e);
            }
        }
        Self { rb, network }
    }

    pub fn save_header(&self, header: String, timestamp: String) {
        let mut block_header = MBlockHeader::default();
        block_header.scanned = "0".to_owned();
        block_header.header = header;
        block_header.timestamp = timestamp;

        let r = block_on(block_header.save(&self.rb, ""));
        match r {
            Ok(a) => {
                debug!("{:?}", a);
            }
            Err(e) => {
                debug!("{:?}", e);
            }
        }
    }

    /// fetch header which needed scan
    /// scan_flag = false scan_flag does not need +1
    /// scan_flag = true scan_flag need +1
    pub fn fetch_scan_header(&self, timestamp: String, scan_flag: bool) -> Vec<String> {
        let w = self
            .rb
            .new_wrapper()
            .gt("timestamp", &timestamp)
            .and()
            .lt("scanned", 6)
            .check()
            .unwrap();
        let req = PageRequest::new(1, 1000);
        let r: Result<Page<MBlockHeader>, _> =
            block_on(self.rb.fetch_page_by_wrapper("", &w, &req));
        let mut block_headers: Vec<MBlockHeader> = vec![];
        match r {
            Ok(page) => {
                let header_vec = page.get_records();
                block_headers = header_vec.to_vec();
            }
            Err(e) => debug!("{:?}", e),
        }
        let mut headers: Vec<String> = vec![];
        for header_block in block_headers {
            headers.push(header_block.header);
        }

        if scan_flag {
            let sql = format!(
                r#"
            UPDATE block_header SET scanned = scanned+1
                WHERE id IN (
                    SELECT id FROM (
                        SELECT id FROM block_header
                        WHERE timestamp >= {}
                        AND scanned <= 5
                        ORDER BY id ASC
                        LIMIT 0, 1000
                    ) tmp
                )
            "#,
                timestamp
            );
            let r = block_on(self.rb.exec("", &sql));
            match r {
                Ok(a) => {
                    debug!("{:?}", a);
                }
                Err(e) => {
                    debug!("{:?}", e);
                }
            }
        }

        headers
    }

    // how may headers save in block_header table
    pub fn fetch_height(&self) -> u64 {
        let py = r#"
        SELECT * FROM block_header
        Order By id DESC
        LIMIT 1;
        "#;
        let r: Result<MBlockHeader, _> = block_on(self.rb.py_fetch("", py, &""));
        match r {
            Ok(r) => r.id.parse::<u64>().unwrap(),
            Err(_) => 0,
        }
    }

    pub fn fetch_header_by_timestamp(&self, timestamp: String) -> Option<MBlockHeader> {
        let w = self.rb.new_wrapper().eq("timestamp", timestamp).check();
        let r = match w {
            Ok(w) => {
                let r: Result<MBlockHeader, _> = block_on(self.rb.fetch_by_wrapper("", &w));
                match r {
                    Ok(header) => Some(header),
                    Err(_) => None,
                }
            }
            Err(_) => None,
        };
        r
    }
}

pub struct DetailSqlite {
    rb: Rbatis,
    network: Network,
}

impl DetailSqlite {
    pub fn new(network: Network, db_file_name: &str) -> Self {
        let rb = block_on(Self::init_rbatis(db_file_name));
        DetailSqlite::create_progress(&rb);
        DetailSqlite::create_user_address(&rb);
        DetailSqlite::create_tx_input(&rb);
        DetailSqlite::create_tx_output(&rb);
        DetailSqlite::create_local_tx(&rb);
        Self { rb, network }
    }

    fn create_user_address(rb: &Rbatis) {
        let r = block_on(rb.exec("", MUserAddress::create_table_script()));
        match r {
            Ok(a) => {
                debug!("create_user_address {:?}", a);
            }
            Err(e) => {
                debug!("create_user_address {:?}", e);
            }
        }
    }

    fn create_tx_input(rb: &Rbatis) {
        let r = block_on(rb.exec("", MTxInput::create_table_script()));
        match r {
            Ok(a) => {
                debug!("create_tx_input {:?}", a);
            }
            Err(e) => {
                debug!("create_tx_input {:?}", e);
            }
        }
    }

    fn create_tx_output(rb: &Rbatis) {
        let r = block_on(rb.exec("", MTxOutput::create_table_script()));
        match r {
            Ok(a) => {
                debug!("create_tx_output {:?}", a);
            }
            Err(e) => {
                debug!("create_tx_output {:?}", e);
            }
        }
    }

    fn create_progress(rb: &Rbatis) {
        let r = block_on(rb.exec("", MProgress::create_table_script()));
        match r {
            Ok(a) => {
                debug!("create_progress {:?}", a);
            }
            Err(e) => {
                debug!("create_progress {:?}", e);
            }
        }
    }

    fn create_local_tx(rb: &Rbatis) {
        let r = block_on(rb.exec("", MLocalTxLog::create_table_script()));
        match r {
            Ok(a) => {
                debug!("create_local_tx {:?}", a);
            }
            Err(e) => {
                debug!("create_local_tx {:?}", e);
            }
        }
    }

    fn save_progress(&self, header: String, timestamp: String) {
        let mut progress = MProgress::default();
        progress.header = header;
        progress.timestamp = timestamp;

        let r = block_on(progress.save(&self.rb, ""));
        match r {
            Ok(a) => {
                debug!("save_progress {:?}", a);
            }
            Err(e) => {
                debug!("save_progress {:?}", e);
            }
        }
    }

    fn fetch_progress(&self) -> Option<MProgress> {
        let r: Result<Option<MProgress>, _> = block_on(self.rb.fetch_by_id("", &"1".to_owned()));
        match r {
            Ok(p) => p,
            Err(_) => None,
        }
    }

    pub fn update_progress(&self, header: String, timestamp: String) {
        let mut progress = MProgress::default();
        progress.header = header;
        progress.timestamp = timestamp;

        let w = self.rb.new_wrapper().eq(MProgress::id, 1).check().unwrap();
        let r = block_on(self.rb.update_by_wrapper("", &progress, &w, false));
        match r {
            Ok(a) => {
                debug!("update_progress {:?}", a);
            }
            Err(e) => {
                debug!("update_progress {:?}", e);
            }
        }
    }

    pub fn progress(&self) -> MProgress {
        let progress = self.fetch_progress();
        match progress {
            None => {
                let genesis = genesis_block(self.network).header;
                let header = genesis.bitcoin_hash().to_hex();
                let timestamp = genesis.time.to_string();
                info!("scanned newest block from genesis {:?}", &genesis);
                self.save_progress(header.clone(), timestamp.clone());
                let mut progress = MProgress::default();
                progress.header = header;
                progress.timestamp = timestamp;
                return progress;
            }
            Some(progress) => progress,
        }
    }

    pub fn save_txin(
        &self,
        tx: String,
        sig_script: String,
        prev_tx: String,
        prev_vout: String,
        sequence: u32,
    ) {
        let mut tx_input = MTxInput::default();
        tx_input.tx = tx;
        tx_input.sig_script = sig_script;
        tx_input.prev_tx = prev_tx;
        tx_input.prev_vout = prev_vout;
        tx_input.sequence = sequence;

        let r = block_on(self.rb.save("", &tx_input));
        match r {
            Ok(a) => {
                debug!("save_tx_input {:?}", a);
            }
            Err(e) => {
                debug!("save_tx_input {:?}", e);
            }
        }
    }

    pub fn save_txout(&self, tx: String, script: String, value: String, vin: String) {
        let mut tx_output = MTxOutput::default();
        tx_output.tx = tx;
        tx_output.script = script;
        tx_output.value = value;
        tx_output.vin = vin;

        let r = block_on(self.rb.save("", &tx_output));
        match r {
            Ok(a) => {
                debug!("save_tx_input {:?}", a);
            }
            Err(e) => {
                debug!("save_tx_input {:?}", e);
            }
        }
    }

    pub fn save_user_address(&self, address: String, compressed_pub_key: String) {
        let mut user_address = MUserAddress::default();
        user_address.address = address;
        user_address.compressed_pub_key = compressed_pub_key;
        let r = block_on(self.rb.save("", &user_address));
        match r {
            Ok(a) => {
                debug!("save_tx_input {:?}", a);
            }
            Err(e) => {
                debug!("save_tx_input {:?}", e);
            }
        }
    }

    pub fn fetch_user_address(&self) -> Option<MUserAddress> {
        let r: Result<Option<MUserAddress>, _> = block_on(self.rb.fetch_by_id("", &"1".to_owned()));
        match r {
            Ok(p) => p,
            Err(_) => None,
        }
    }
}

pub fn fetch_scanned_height() -> u64 {
    let mprogress = RB_DETAIL.progress();
    let header = RB_CHAIN.fetch_header_by_timestamp(mprogress.timestamp);
    match header {
        None => 0,
        Some(header) => header.id.parse::<u64>().unwrap(),
    }
}

#[async_trait]
trait RInit {
    async fn init_rbatis(db_file_name: &str) -> Rbatis {
        if std::fs::metadata(db_file_name).is_err() {
            let file = std::fs::File::create(db_file_name);
            if file.is_err() {
                info!("error when init file {:?}", file.err().unwrap());
            }
        }
        let rb = Rbatis::new();
        let url = "sqlite://".to_owned().add(db_file_name);
        info!("file url: {:?}", url);
        let r = rb.link(url.as_str()).await;
        if r.is_err() {
            info!("{:?}", r.err().unwrap());
        }
        rb
    }
}

#[async_trait]
impl RInit for ChainSqlite {}

#[async_trait]
impl RInit for DetailSqlite {}

pub static RB_CHAIN: Lazy<ChainSqlite> =
    Lazy::new(|| ChainSqlite::new(Network::Testnet, BTC_CHAIN_PATH));

pub static RB_DETAIL: Lazy<DetailSqlite> =
    Lazy::new(|| DetailSqlite::new(Network::Testnet, BTC_DETAIL_PATH));