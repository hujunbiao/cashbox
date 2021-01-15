#![allow(non_snake_case)]

use std::os::raw::c_char;
use futures::executor::block_on;
use mav::NetType;
use wallets_types::Error;
use wallets::Contexts;
use super::types::CError;
use super::kits::{CR, to_c_char, to_str};

use crate::parameters::{CContext, CEthTransferPayload, CEthRawTxPayload};
use crate::CStruct;
use crate::kits::CArray;
use crate::chain_eth::{CEthChainTokenAuth, CEthChainTokenDefault, CEthChainTokenShared};

#[no_mangle]
pub unsafe extern "C" fn ChainEth_decodeAdditionData(ctx: *mut CContext,encodeData: *mut c_char, additionData: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee ChainEth decodeAdditionData");

    if ctx.is_null() || encodeData.is_null() || additionData.is_null() {
        let err = Error::PARAMETER().append_message(" : encodeData or additionData is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*additionData).free();//如果内存已存在，释放它
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eth_chain = wallets.eth_chain_instance();
                match block_on(eth_chain.decode_addition_data(to_str(encodeData))) {
                    Ok(res) => {
                        *additionData = to_c_char(&res);
                        Error::SUCCESS()
                    }
                    Err(err) => Error::from(err)
                }
            }
            None => Error::NONE().append_message(": can not find the context")
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}
#[no_mangle]
pub unsafe extern "C" fn ChainEth_txSign(ctx: *mut CContext,netType: *mut c_char,txPayload: *mut CEthTransferPayload,password: *mut c_char, signResult: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee ChainEth txSign");

    if ctx.is_null() || netType.is_null() || txPayload.is_null()|| password.is_null()  || signResult.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,netType,txPayload,password or signResult is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*signResult).free();//如果内存已存在，释放它
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eth_chain = wallets.eth_chain_instance();
                let transfer_payload = CEthTransferPayload::ptr_rust(txPayload);
                let net_type = NetType::from(to_str(netType));
                match block_on(eth_chain.tx_sign(wallets, &net_type, &transfer_payload, to_str(password))) {
                    Ok(res) => {
                        *signResult = to_c_char(&res);
                        Error::SUCCESS()
                    }
                    Err(err) => Error::from(err)
                }
            }
            None => Error::NONE().append_message(": can not find the context")
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

#[no_mangle]
pub unsafe extern "C" fn ChainEth_rawTxSign(ctx: *mut CContext,netType: *mut c_char,rawTxPayload: *mut CEthRawTxPayload, password: *mut c_char,signResult: *mut *mut c_char) -> *const CError {
    log::debug!("enter ChainEee ChainEth rawTxSign");

    if ctx.is_null() || netType.is_null() || rawTxPayload.is_null()|| password.is_null()  || signResult.is_null() {
        let err = Error::PARAMETER().append_message(" : netType,rawTxPayload,password or signResult is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*signResult).free();//如果内存已存在，释放它
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eth_chain = wallets.eth_chain_instance();
                let raw_tx_payload = CEthRawTxPayload::ptr_rust(rawTxPayload); //wallets, &net_type, &transferPayload)) {
                let net_type = NetType::from(to_str(netType));
                match block_on(eth_chain.raw_tx_sign(wallets,&net_type,&raw_tx_payload,to_str(password))) {
                    Ok(res) => {
                        *signResult = to_c_char(&res);
                        Error::SUCCESS()
                    }
                    Err(err) => Error::from(err)
                }
            }
            None => Error::NONE().append_message(": can not find the context")
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}
#[no_mangle]
pub unsafe extern "C" fn ChainEth_updateAuthTokenList(ctx: *mut CContext, netType: *mut c_char, authTokens: *mut CArray<CEthChainTokenShared>) -> *const CError {


    unimplemented!()
}


#[no_mangle]
pub unsafe extern "C" fn ChainEth_updateDefaultTokenList(ctx: *mut CContext, defaultTokens: *mut CArray<CEthChainTokenDefault>) -> *const CError {
    log::debug!("enter ChainEee ChainEth rawTxSign");

    if ctx.is_null() || defaultTokens.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,defaultTokens is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let eth_chain = wallets.eth_chain_instance();
                let default_token_list = CArray::<CEthChainTokenDefault>::ptr_rust(defaultTokens); //wallets, &net_type, &transferPayload)) {
                match block_on(eth_chain.update_default_tokens(wallets,default_token_list)) {
                    Ok(_) => {
                        Error::SUCCESS()
                    }
                    Err(err) => Error::from(err)
                }
            }
            None => Error::NONE().append_message(": can not find the context")
        }
    };
    log::debug!("{}", err);
    CError::to_c_ptr(&err)
}

//support non auth digit?
#[no_mangle]
pub unsafe extern "C" fn ChainEth_addNonAuthDigit(_ctx: *mut CContext, _netType: *mut c_char, _tokens: *mut CEthChainTokenDefault) -> *const CError {

    unimplemented!()
}

#[no_mangle]
pub unsafe extern "C" fn ChainEth_updateDigitBalance(_ctx: *mut CContext, _netType: *mut c_char, _tokens: *mut CEthChainTokenDefault) -> *const CError {

    unimplemented!()
}
