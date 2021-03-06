use std::ptr::null_mut;
use std::time::{Duration, Instant};

use futures::task::SpawnExt;

use mav::{kits, WalletType};
use wallets_cdl::{mem_c::{
    CContext_dAlloc, CContext_dFree, CError_free, CStr_dAlloc, CStr_dFree, CWallet_dAlloc,
    CWallet_dFree,
}, parameters::{CContext, CCreateWalletParameters, CInitParameters}, types::{CError, CWallet, CR, CU64}, wallets_c::{
    Wallets_createWallet, Wallets_findById, Wallets_generateMnemonic, Wallets_init,
    Wallets_uninit,
}, CArray};
use wallets_cdl::{to_c_char, to_str, CStruct};
use wallets_types::{CreateWalletParameters, Error, InitParameters, Wallet};
use wallets_cdl::wallets_c::{Wallets_appPlatformType, Wallets_removeWallet, Wallets_all};
use wallets_cdl::mem_c::{CStr_free, CArrayCWallet_dAlloc, CArrayCWallet_dFree};
use std::os::raw::c_char;

#[test]
fn executor_test() {
    let ex = {
        let mut bu = futures::executor::ThreadPool::builder();
        bu.pool_size(4);
        bu.create().unwrap()
    };
    println!("test thread: {:?}", std::thread::current().id());
    let _ = ex.spawn(async {
        std::thread::sleep(Duration::from_secs(5));
        println!(
            "futures::executor::ThreadPool : {:?}",
            std::thread::current().id()
        );
        ()
    });
    println!("after futures::executor::ThreadPool ");
    std::thread::sleep(Duration::from_secs(10));

    std::env::set_var("ASYNC_STD_THREAD_COUNT", "4");
    let j = async_std::task::spawn(async {
        let a = async_std::task::spawn(async {
            println!(
                "async_std::task::spawn 1: {:?}",
                std::thread::current().id()
            );
            println!("1 s");
            std::thread::sleep(Duration::from_secs(2));
            println!("1 end");
            1
        });
        let b = async_std::task::spawn(async {
            println!(
                "async_std::task::spawn 2: {:?}",
                std::thread::current().id()
            );
            println!("2");
            2
        });
        //futures::join!( a,  b);
        futures::future::join(a, b).await;
        1
    });
    futures::executor::block_on(j);
    println!("done block_on");
}

#[test]
fn block_on_test() {
    let block_async_std = |k: u64| -> u64 {
        let start = Instant::now();
        for _ in 0..k {
            async_std::task::block_on(async { 1 });
        }
        start.elapsed().as_nanos() as u64
    };
    let block_futures = |k: u64| -> u64 {
        let start = Instant::now();
        for _ in 0..k {
            futures::executor::block_on(async { 1 });
        }
        start.elapsed().as_nanos() as u64
    };
    let block_futures_lite = |k: u64| -> u64 {
        let start = Instant::now();
        for _ in 0..k {
            futures_lite::future::block_on(async { 1 });
        }
        start.elapsed().as_nanos() as u64
    };
    let block_tokio = |k: u64| -> u64 {
        let start = Instant::now();
        let r = tokio::runtime::Builder::new_current_thread()
            .build()
            .unwrap();
        for _ in 0..k {
            r.block_on(async { 1 });
        }
        start.elapsed().as_nanos() as u64
    };

    let block_smol = |k: u64| -> u64 {
        let start = Instant::now();
        for _ in 0..k {
            smol::block_on(async { 1 });
        }
        start.elapsed().as_nanos() as u64
    };

    let k = 100u64;
    let elapsed_futures = block_futures(k) / k;
    let elapsed_futures_lite = block_futures_lite(k) / k;
    let elapsed_async = block_async_std(k) / k;
    let elapsed_tokio = block_tokio(k) / k;
    let elapsed_smol = block_smol(k) / k;
    println!(
        "async_std::task::block_on:      {}(nanoseconds) \n\
                  futures::executor::block_on:    {}(nanoseconds) \n\
                  futures_lite::block_on:         {}(nanoseconds) \n\
                  tokio::runtime::current_thread: {}(nanoseconds) \n\
                  smol::block_on:                 {}(nanoseconds)",
        elapsed_async, elapsed_futures, elapsed_futures_lite, elapsed_tokio, elapsed_smol
    );
    // sample out
    // async_std::task::block_on:      42487(nanoseconds)
    // futures::executor::block_on:    423(nanoseconds)
    // futures_lite::block_on:         255(nanoseconds)
    // tokio::runtime::current_thread: 3275(nanoseconds)
    // smol::block_on:                 2154(nanoseconds)
    // 1000次以上时futures_lite的速度最快，最后选择futures::executor::block_on是因为它的更有名，且经过反复的考验
    // 单次起动 smol::block_on最快，单从性能上看smol的作者（futures_lite作者相同）作了很多优化工作，它的库可以作为参考
}

#[test]
fn mnemonic_test() {
    unsafe {
        //invalid parameters
        let c_err = Wallets_generateMnemonic(null_mut()) as *mut CError;
        assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
    }
    unsafe {
        let ptr = CStr_dAlloc();
        let c_err = Wallets_generateMnemonic(ptr) as *mut CError;
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        let words: Vec<&str> = to_str(*ptr).split(" ").collect();
        CStr_dFree(ptr);
        CError_free(c_err);
        assert_eq!(15, words.len());
    }
}

#[test]
fn plat_type_test() {
    unsafe {
        let ptr = Wallets_appPlatformType() as *mut c_char;
        assert_ne!(null_mut(), ptr);
        CStr_free(ptr);
    }
}

#[test]
fn wallets_test() {
    init_test();
    unsafe {
        let c_ctx = {
            let c_ctx = CContext_dAlloc();
            let parameters = init_parameters();
            let mut c_parameters = CInitParameters::to_c_ptr(&parameters);
            {
                let c_err = Wallets_init(c_parameters, c_ctx) as *mut CError;
                assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
                CError_free(c_err);
            }
            c_parameters.free();
            c_ctx
        };

        let mnemonic = {
            let p_mn = CStr_dAlloc();
            {
                let c_err = Wallets_generateMnemonic(p_mn) as *mut CError;
                assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
                CError_free(c_err);
            }
            let mn = to_str(*p_mn).to_owned();
            CStr_dFree(p_mn);
            mn
        };
        let wallet = {
            {
                //invalid parameters
                let mut parameters = CCreateWalletParameters::to_c_ptr(&CreateWalletParameters {
                    name: "test".to_owned(),
                    password: "1".to_string(),
                    mnemonic: mnemonic.clone(),
                    wallet_type: WalletType::Normal.to_string(),
                });
                let mut c_wallet = CWallet_dAlloc();
                {
                    let c_err =
                        Wallets_createWallet(null_mut(), null_mut(), null_mut()) as *mut CError;
                    assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
                    CError_free(c_err);

                    let c_err =
                        Wallets_createWallet(null_mut(), parameters, null_mut()) as *mut CError;
                    assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
                    CError_free(c_err);

                    let c_err =
                        Wallets_createWallet(null_mut(), null_mut(), c_wallet) as *mut CError;
                    assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
                    CError_free(c_err);

                    let c_err = Wallets_createWallet(*c_ctx, null_mut(), null_mut()) as *mut CError;
                    assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
                    CError_free(c_err);

                    let c_err = Wallets_createWallet(*c_ctx, parameters, null_mut()) as *mut CError;
                    assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
                    CError_free(c_err);

                    let c_err = Wallets_createWallet(*c_ctx, null_mut(), c_wallet) as *mut CError;
                    assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
                    CError_free(c_err);
                }
                c_wallet.free();
                parameters.free();
            }

            let c_wallet = CWallet_dAlloc();

            let parameters = CreateWalletParameters {
                name: "test".to_owned(),
                password: "1".to_string(),
                mnemonic: mnemonic.clone(),
                wallet_type: WalletType::Normal.to_string(),
            };
            let mut c_parameters = CCreateWalletParameters::to_c_ptr(&parameters);
            let c_err = Wallets_createWallet(*c_ctx, c_parameters, c_wallet) as *mut CError;
            c_parameters.free();
            assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
            CError_free(c_err);

            assert_ne!(null_mut(), *c_wallet);
            let w = CWallet::to_rust(&**c_wallet);
            CWallet_dFree(c_wallet);
            w
        };

        let temp = find_by_id_test(*c_ctx, &wallet.id);
        assert_eq!(wallet.id, temp.id);
        assert_eq!(wallet.name, temp.name);
        let c_array_wallet = CArrayCWallet_dAlloc();
        let c_err = Wallets_all(*c_ctx, c_array_wallet) as *mut CError;
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        let wallets: Vec<Wallet> = CArray::to_rust(&**c_array_wallet);
        CArrayCWallet_dFree(c_array_wallet);
        CContext_dFree(c_ctx);
    }
}

//单元测试是并行的，这里把它放入一个测试中进行测试，以减少并行给单元测试带来的问题
fn init_test() {
    unsafe {
        //参数不正确的测试
        let c_err = Wallets_init(null_mut(), null_mut()) as *mut CError;
        assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);

        let mut parameters = CInitParameters::to_c_ptr(&init_parameters());
        {
            let c_err = Wallets_init(parameters, null_mut()) as *mut CError;
            assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
            CError_free(c_err);

            let ctx = CContext_dAlloc();
            {
                assert_ne!(null_mut(), ctx);
                let c_err = Wallets_init(null_mut(), ctx) as *mut CError;
                assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
                CError_free(c_err);
            }
            CContext_dFree(ctx);
        }
        parameters.free();
    }
    unsafe {
        let ctx = CContext_dAlloc();
        assert_ne!(null_mut(), ctx);
        let parameters = init_parameters();
        let mut c_parameters = CInitParameters::to_c_ptr(&parameters);
        let c_err = Wallets_init(c_parameters, ctx) as *mut CError;
        assert_ne!(null_mut(), c_err);
        assert_eq!(0 as CU64, (*c_err).code, "{:?}", *c_err);
        CError_free(c_err);
        c_parameters.free();

        assert_ne!(null_mut(), *ctx);
        assert_eq!(
            parameters.context_note.as_str(),
            to_str((**ctx).contextNote)
        );
        assert_ne!(0, to_str((**ctx).id).len());

        {
            //only release memory
            let c_err = Wallets_uninit(*ctx) as *mut CError;
            assert_ne!(null_mut(), c_err);
            CError_free(c_err);
            CContext_dFree(ctx);
        }
    }
}

fn find_by_id_test(c_ctx: *mut CContext, wallet_id: &str) -> Wallet {
    unsafe {
        //invalid parameters

        let mut c_wallet_id = to_c_char("t");
        let mut c_wallet = CWallet_dAlloc();
        {
            let c_err = Wallets_findById(null_mut(), null_mut(), null_mut()) as *mut CError;
            assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
            CError_free(c_err);
            let c_err = Wallets_findById(null_mut(), c_wallet_id, null_mut()) as *mut CError;
            assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
            CError_free(c_err);
            let c_err = Wallets_findById(null_mut(), null_mut(), c_wallet) as *mut CError;
            assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
            CError_free(c_err);

            let c_err = Wallets_findById(c_ctx, null_mut(), null_mut()) as *mut CError;
            assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
            CError_free(c_err);
            let c_err = Wallets_findById(c_ctx, c_wallet_id, null_mut()) as *mut CError;
            assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
            CError_free(c_err);
            let c_err = Wallets_findById(c_ctx, null_mut(), c_wallet) as *mut CError;
            assert_eq!(Error::PARAMETER().code, (*c_err).code, "{:?}", *c_err);
            CError_free(c_err);
        }
        c_wallet.free();
        c_wallet_id.free();
    }

    let wallet = unsafe {
        let mut c_wallet_id = to_c_char(wallet_id);
        let mut c_wallet = CWallet_dAlloc();
        {
            let mut not_id = to_c_char(kits::uuid().as_str());
            let c_err = Wallets_findById(c_ctx, not_id, c_wallet) as *mut CError;
            assert_eq!(Error::NoRecord().code, (*c_err).code, "{:?}", *c_err);
            CError_free(c_err);
            not_id.free();

            let c_err = Wallets_findById(c_ctx, c_wallet_id, c_wallet) as *mut CError;
            assert_eq!(Error::SUCCESS().code, (*c_err).code, "{:?}", *c_err);
            CError_free(c_err);
        }
        let wallet = CWallet::to_rust(&**c_wallet);
        c_wallet.free();
        c_wallet_id.free();
        wallet
    };
    wallet
}

fn init_parameters() -> InitParameters {
    let mut p = InitParameters::default();
    p.db_name.0 = mav::ma::DbName::new("test_", "");
    p.context_note = format!("test_{}", kits::uuid());
    p
}