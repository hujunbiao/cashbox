#![allow(non_snake_case)]

use futures::executor::block_on;
use wallets_types::Error;
use wallets::Contexts;
use mav::NetType;
use super::types::CError;
use super::kits::{CR,CArray};

use crate::types::{CBtcChainTokenDefault, CBtcChainTokenAuth};
use crate::parameters::CContext;
use std::os::raw::{c_char, c_uint};
use crate::{to_str, CStruct};


#[no_mangle]
pub unsafe extern "C" fn ChainBtc_updateDefaultTokenList(ctx: *mut CContext, defaultTokens: *mut CArray<CBtcChainTokenDefault>) -> *const CError {
    log::debug!("enter ChainEth updateDefaultTokenLis");

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
                let btc_chain = wallets.btc_chain_instance();
                let default_token_list = CArray::<CBtcChainTokenDefault>::ptr_rust(defaultTokens);
                match block_on(btc_chain.update_default_tokens(wallets, default_token_list)) {
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
#[no_mangle]
pub unsafe extern "C" fn ChainBtc_updateAuthDigitList(ctx: *mut CContext,authTokens: *mut CArray<CBtcChainTokenAuth>) -> *const CError {
    log::debug!("enter ChainBtc updateDefaultTokenLis");

    if ctx.is_null() || authTokens.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,authTokens is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let btc_chain = wallets.btc_chain_instance();
                let default_token_list = CArray::<CBtcChainTokenAuth>::ptr_rust(authTokens);
                match block_on(btc_chain.update_auth_tokens(wallets, default_token_list)) {
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

#[no_mangle]
pub unsafe extern "C" fn ChainBtc_getAuthTokenList(ctx: *mut CContext, netType: *mut c_char, startItem: c_uint, pageSize: c_uint, tokens: *mut *mut CArray<CBtcChainTokenAuth>) -> *const CError {
    log::debug!("enter ChainEth getDigitList");

    if ctx.is_null() || tokens.is_null() || netType.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,tokens,netType is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*tokens).free();
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let btc_chain = wallets.btc_chain_instance();
                let net_type = NetType::from(to_str(netType));
                match block_on(btc_chain.get_auth_tokens(wallets, &net_type, startItem as u64, pageSize as u64)) {
                    Ok(data) => {
                        *tokens = CArray::to_c_ptr(&data);
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
pub unsafe extern "C" fn ChainBtc_getDefaultTokenList(ctx: *mut CContext, netType: *mut c_char, tokens: *mut *mut CArray<CBtcChainTokenDefault>) -> *const CError {
    log::debug!("enter ChainEth getDigitList");

    if ctx.is_null() || tokens.is_null() || netType.is_null() {
        let err = Error::PARAMETER().append_message(" : ctx,tokens,netType is null");
        log::error!("{}", err);
        return CError::to_c_ptr(&err);
    }
    (*tokens).free();
    let lock = Contexts::collection().lock();
    let mut contexts = lock.borrow_mut();
    let err = {
        let ctx = CContext::ptr_rust(ctx);
        match contexts.get(&ctx.id) {
            Some(wallets) => {
                let btc_chain = wallets.btc_chain_instance();
                let net_type = NetType::from(to_str(netType));
                match block_on(btc_chain.get_default_tokens(wallets, &net_type)) {
                    Ok(data) => {
                        *tokens = CArray::to_c_ptr(&data);
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
