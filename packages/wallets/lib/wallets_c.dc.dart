// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// DCGenerator
// **************************************************************************

import 'dart:ffi';

import 'package:ffi/ffi.dart' as ffi;

import 'kits.dart';
import 'wallets_c.dart' as clib;

class AccountInfo extends DC<clib.CAccountInfo> {
  int nonce;
  int ref_count;
  String free_;
  String reserved;
  String misc_frozen;
  String fee_frozen;

  static free(Pointer<clib.CAccountInfo> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.free_ != null && ptr.ref.free_ != nullptr) {
      ffi.free(ptr.ref.free_);
    }
    ptr.ref.free_ = nullptr;
    if (ptr.ref.reserved != null && ptr.ref.reserved != nullptr) {
      ffi.free(ptr.ref.reserved);
    }
    ptr.ref.reserved = nullptr;
    if (ptr.ref.misc_frozen != null && ptr.ref.misc_frozen != nullptr) {
      ffi.free(ptr.ref.misc_frozen);
    }
    ptr.ref.misc_frozen = nullptr;
    if (ptr.ref.fee_frozen != null && ptr.ref.fee_frozen != nullptr) {
      ffi.free(ptr.ref.fee_frozen);
    }
    ptr.ref.fee_frozen = nullptr;
    ffi.free(ptr);
  }

  static AccountInfo fromC(Pointer<clib.CAccountInfo> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new AccountInfo();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAccountInfo> toCPtr() {
    var ptr = allocateZero<clib.CAccountInfo>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CAccountInfo> c) {
    if (c == null || c == nullptr) {
      return;
    }
    c.ref.nonce = nonce;
    c.ref.ref_count = ref_count;
    if (c.ref.free_ != null && c.ref.free_ != nullptr) {
      ffi.free(c.ref.free_);
    }
    c.ref.free_ = toUtf8Null(free_);
    if (c.ref.reserved != null && c.ref.reserved != nullptr) {
      ffi.free(c.ref.reserved);
    }
    c.ref.reserved = toUtf8Null(reserved);
    if (c.ref.misc_frozen != null && c.ref.misc_frozen != nullptr) {
      ffi.free(c.ref.misc_frozen);
    }
    c.ref.misc_frozen = toUtf8Null(misc_frozen);
    if (c.ref.fee_frozen != null && c.ref.fee_frozen != nullptr) {
      ffi.free(c.ref.fee_frozen);
    }
    c.ref.fee_frozen = toUtf8Null(fee_frozen);
  }

  @override
  toDart(Pointer<clib.CAccountInfo> c) {
    if (c == null || c == nullptr) {
      return;
    }
    nonce = c.ref.nonce;
    ref_count = c.ref.ref_count;
    free_ = fromUtf8Null(c.ref.free_);
    reserved = fromUtf8Null(c.ref.reserved);
    misc_frozen = fromUtf8Null(c.ref.misc_frozen);
    fee_frozen = fromUtf8Null(c.ref.fee_frozen);
  }
}

class AccountInfoSyncProg extends DC<clib.CAccountInfoSyncProg> {
  String account;
  String blockNo;
  String blockHash;

  static free(Pointer<clib.CAccountInfoSyncProg> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.account != null && ptr.ref.account != nullptr) {
      ffi.free(ptr.ref.account);
    }
    ptr.ref.account = nullptr;
    if (ptr.ref.blockNo != null && ptr.ref.blockNo != nullptr) {
      ffi.free(ptr.ref.blockNo);
    }
    ptr.ref.blockNo = nullptr;
    if (ptr.ref.blockHash != null && ptr.ref.blockHash != nullptr) {
      ffi.free(ptr.ref.blockHash);
    }
    ptr.ref.blockHash = nullptr;
    ffi.free(ptr);
  }

  static AccountInfoSyncProg fromC(Pointer<clib.CAccountInfoSyncProg> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new AccountInfoSyncProg();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAccountInfoSyncProg> toCPtr() {
    var ptr = allocateZero<clib.CAccountInfoSyncProg>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CAccountInfoSyncProg> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.account != null && c.ref.account != nullptr) {
      ffi.free(c.ref.account);
    }
    c.ref.account = toUtf8Null(account);
    if (c.ref.blockNo != null && c.ref.blockNo != nullptr) {
      ffi.free(c.ref.blockNo);
    }
    c.ref.blockNo = toUtf8Null(blockNo);
    if (c.ref.blockHash != null && c.ref.blockHash != nullptr) {
      ffi.free(c.ref.blockHash);
    }
    c.ref.blockHash = toUtf8Null(blockHash);
  }

  @override
  toDart(Pointer<clib.CAccountInfoSyncProg> c) {
    if (c == null || c == nullptr) {
      return;
    }
    account = fromUtf8Null(c.ref.account);
    blockNo = fromUtf8Null(c.ref.blockNo);
    blockHash = fromUtf8Null(c.ref.blockHash);
  }
}

class Address extends DC<clib.CAddress> {
  String id;
  String walletId;
  String chainType;
  String address;
  String publicKey;

  static free(Pointer<clib.CAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.id != null && ptr.ref.id != nullptr) {
      ffi.free(ptr.ref.id);
    }
    ptr.ref.id = nullptr;
    if (ptr.ref.walletId != null && ptr.ref.walletId != nullptr) {
      ffi.free(ptr.ref.walletId);
    }
    ptr.ref.walletId = nullptr;
    if (ptr.ref.chainType != null && ptr.ref.chainType != nullptr) {
      ffi.free(ptr.ref.chainType);
    }
    ptr.ref.chainType = nullptr;
    if (ptr.ref.address != null && ptr.ref.address != nullptr) {
      ffi.free(ptr.ref.address);
    }
    ptr.ref.address = nullptr;
    if (ptr.ref.publicKey != null && ptr.ref.publicKey != nullptr) {
      ffi.free(ptr.ref.publicKey);
    }
    ptr.ref.publicKey = nullptr;
    ffi.free(ptr);
  }

  static Address fromC(Pointer<clib.CAddress> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new Address();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAddress> toCPtr() {
    var ptr = allocateZero<clib.CAddress>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.id != null && c.ref.id != nullptr) {
      ffi.free(c.ref.id);
    }
    c.ref.id = toUtf8Null(id);
    if (c.ref.walletId != null && c.ref.walletId != nullptr) {
      ffi.free(c.ref.walletId);
    }
    c.ref.walletId = toUtf8Null(walletId);
    if (c.ref.chainType != null && c.ref.chainType != nullptr) {
      ffi.free(c.ref.chainType);
    }
    c.ref.chainType = toUtf8Null(chainType);
    if (c.ref.address != null && c.ref.address != nullptr) {
      ffi.free(c.ref.address);
    }
    c.ref.address = toUtf8Null(address);
    if (c.ref.publicKey != null && c.ref.publicKey != nullptr) {
      ffi.free(c.ref.publicKey);
    }
    c.ref.publicKey = toUtf8Null(publicKey);
  }

  @override
  toDart(Pointer<clib.CAddress> c) {
    if (c == null || c == nullptr) {
      return;
    }
    id = fromUtf8Null(c.ref.id);
    walletId = fromUtf8Null(c.ref.walletId);
    chainType = fromUtf8Null(c.ref.chainType);
    address = fromUtf8Null(c.ref.address);
    publicKey = fromUtf8Null(c.ref.publicKey);
  }
}

class ArrayCBtcChainToken extends DC<clib.CArrayCBtcChainToken> {
  List<BtcChainToken> data;

  ArrayCBtcChainToken() {
    data = new List<BtcChainToken>();
  }

  static free(Pointer<clib.CArrayCBtcChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    BtcChainToken.free(ptr.ref.ptr);
    ffi.free(ptr);
  }

  static ArrayCBtcChainToken fromC(Pointer<clib.CArrayCBtcChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCBtcChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCBtcChainToken> toCPtr() {
    var c = allocateZero<clib.CArrayCBtcChainToken>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCBtcChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.ptr != nullptr && c.ref.ptr != null) {
      BtcChainToken.free(c.ref.ptr);
    }
    c.ref.ptr = allocateZero<clib.CBtcChainToken>(count: data.length);
    c.ref.len = data.length;
    c.ref.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ref.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCBtcChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    data = new List<BtcChainToken>(c.ref.len);
    for (var i = 0; i < data.length; i++) {
      data[i].toDart(c.ref.ptr.elementAt(i));
    }
  }
}

class ArrayCContext extends DC<clib.CArrayCContext> {
  List<Context> data;

  ArrayCContext() {
    data = new List<Context>();
  }

  static free(Pointer<clib.CArrayCContext> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    Context.free(ptr.ref.ptr);
    ffi.free(ptr);
  }

  static ArrayCContext fromC(Pointer<clib.CArrayCContext> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCContext();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCContext> toCPtr() {
    var c = allocateZero<clib.CArrayCContext>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCContext> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.ptr != nullptr && c.ref.ptr != null) {
      Context.free(c.ref.ptr);
    }
    c.ref.ptr = allocateZero<clib.CContext>(count: data.length);
    c.ref.len = data.length;
    c.ref.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ref.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCContext> c) {
    if (c == null || c == nullptr) {
      return;
    }
    data = new List<Context>(c.ref.len);
    for (var i = 0; i < data.length; i++) {
      data[i].toDart(c.ref.ptr.elementAt(i));
    }
  }
}

class ArrayCEeeChainToken extends DC<clib.CArrayCEeeChainToken> {
  List<EeeChainToken> data;

  ArrayCEeeChainToken() {
    data = new List<EeeChainToken>();
  }

  static free(Pointer<clib.CArrayCEeeChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    EeeChainToken.free(ptr.ref.ptr);
    ffi.free(ptr);
  }

  static ArrayCEeeChainToken fromC(Pointer<clib.CArrayCEeeChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCEeeChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEeeChainToken> toCPtr() {
    var c = allocateZero<clib.CArrayCEeeChainToken>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCEeeChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.ptr != nullptr && c.ref.ptr != null) {
      EeeChainToken.free(c.ref.ptr);
    }
    c.ref.ptr = allocateZero<clib.CEeeChainToken>(count: data.length);
    c.ref.len = data.length;
    c.ref.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ref.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEeeChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    data = new List<EeeChainToken>(c.ref.len);
    for (var i = 0; i < data.length; i++) {
      data[i].toDart(c.ref.ptr.elementAt(i));
    }
  }
}

class ArrayCEthChainToken extends DC<clib.CArrayCEthChainToken> {
  List<EthChainToken> data;

  ArrayCEthChainToken() {
    data = new List<EthChainToken>();
  }

  static free(Pointer<clib.CArrayCEthChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    EthChainToken.free(ptr.ref.ptr);
    ffi.free(ptr);
  }

  static ArrayCEthChainToken fromC(Pointer<clib.CArrayCEthChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCEthChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEthChainToken> toCPtr() {
    var c = allocateZero<clib.CArrayCEthChainToken>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCEthChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.ptr != nullptr && c.ref.ptr != null) {
      EthChainToken.free(c.ref.ptr);
    }
    c.ref.ptr = allocateZero<clib.CEthChainToken>(count: data.length);
    c.ref.len = data.length;
    c.ref.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ref.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEthChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    data = new List<EthChainToken>(c.ref.len);
    for (var i = 0; i < data.length; i++) {
      data[i].toDart(c.ref.ptr.elementAt(i));
    }
  }
}

class ArrayCWallet extends DC<clib.CArrayCWallet> {
  List<Wallet> data;

  ArrayCWallet() {
    data = new List<Wallet>();
  }

  static free(Pointer<clib.CArrayCWallet> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    Wallet.free(ptr.ref.ptr);
    ffi.free(ptr);
  }

  static ArrayCWallet fromC(Pointer<clib.CArrayCWallet> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayCWallet();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCWallet> toCPtr() {
    var c = allocateZero<clib.CArrayCWallet>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayCWallet> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.ptr != nullptr && c.ref.ptr != null) {
      Wallet.free(c.ref.ptr);
    }
    c.ref.ptr = allocateZero<clib.CWallet>(count: data.length);
    c.ref.len = data.length;
    c.ref.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      data[i].toC(c.ref.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCWallet> c) {
    if (c == null || c == nullptr) {
      return;
    }
    data = new List<Wallet>(c.ref.len);
    for (var i = 0; i < data.length; i++) {
      data[i].toDart(c.ref.ptr.elementAt(i));
    }
  }
}

class ArrayI64 extends DC<clib.CArrayI64> {
  List<int> data;

  ArrayI64() {
    data = new List<int>();
  }

  static free(Pointer<clib.CArrayI64> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    ffi.free(ptr.ref.ptr);
    ffi.free(ptr);
  }

  static ArrayI64 fromC(Pointer<clib.CArrayI64> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ArrayI64();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayI64> toCPtr() {
    var c = allocateZero<clib.CArrayI64>();
    toC(c);
    return c;
  }

  @override
  toC(Pointer<clib.CArrayI64> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.ptr != nullptr && c.ref.ptr != null) {
      ffi.free(c.ref.ptr);
    }
    c.ref.ptr = allocateZero<Int64>(count: data.length);
    c.ref.len = data.length;
    c.ref.cap = data.length;
    for (var i = 0; i < data.length; i++) {
      c.ref.ptr.elementAt(i).value = data[i];
    }
  }

  @override
  toDart(Pointer<clib.CArrayI64> c) {
    if (c == null || c == nullptr) {
      return;
    }
    data = new List<int>(c.ref.len);
    for (var i = 0; i < data.length; i++) {
      data[i] = c.ref.ptr.elementAt(i).value;
    }
  }
}

class BtcChain extends DC<clib.CBtcChain> {
  ChainShared chainShared;
  ArrayCBtcChainToken tokens;

  BtcChain() {
    chainShared = new ChainShared();
    tokens = new ArrayCBtcChainToken();
  }

  static free(Pointer<clib.CBtcChain> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    ChainShared.free(ptr.ref.chainShared);
    ptr.ref.chainShared = nullptr;
    ArrayCBtcChainToken.free(ptr.ref.tokens);
    ptr.ref.tokens = nullptr;
    ffi.free(ptr);
  }

  static BtcChain fromC(Pointer<clib.CBtcChain> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new BtcChain();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChain> toCPtr() {
    var ptr = allocateZero<clib.CBtcChain>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcChain> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.chainShared == null || c.ref.chainShared == nullptr) {
      c.ref.chainShared = allocateZero<clib.CChainShared>();
    }
    chainShared.toC(c.ref.chainShared);
    if (c.ref.tokens == null || c.ref.tokens == nullptr) {
      c.ref.tokens = allocateZero<clib.CArrayCBtcChainToken>();
    }
    tokens.toC(c.ref.tokens);
  }

  @override
  toDart(Pointer<clib.CBtcChain> c) {
    if (c == null || c == nullptr) {
      return;
    }
    chainShared = new ChainShared();
    chainShared.toDart(c.ref.chainShared);
    tokens = new ArrayCBtcChainToken();
    tokens.toDart(c.ref.tokens);
  }
}

class BtcChainToken extends DC<clib.CBtcChainToken> {
  BtcChainTokenShared btcChainTokenShared;

  BtcChainToken() {
    btcChainTokenShared = new BtcChainTokenShared();
  }

  static free(Pointer<clib.CBtcChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    BtcChainTokenShared.free(ptr.ref.btcChainTokenShared);
    ptr.ref.btcChainTokenShared = nullptr;
    ffi.free(ptr);
  }

  static BtcChainToken fromC(Pointer<clib.CBtcChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new BtcChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChainToken> toCPtr() {
    var ptr = allocateZero<clib.CBtcChainToken>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.btcChainTokenShared == null ||
        c.ref.btcChainTokenShared == nullptr) {
      c.ref.btcChainTokenShared = allocateZero<clib.CBtcChainTokenShared>();
    }
    btcChainTokenShared.toC(c.ref.btcChainTokenShared);
  }

  @override
  toDart(Pointer<clib.CBtcChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    btcChainTokenShared = new BtcChainTokenShared();
    btcChainTokenShared.toDart(c.ref.btcChainTokenShared);
  }
}

class BtcChainTokenShared extends DC<clib.CBtcChainTokenShared> {
  TokenShared tokenShared;

  BtcChainTokenShared() {
    tokenShared = new TokenShared();
  }

  static free(Pointer<clib.CBtcChainTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    TokenShared.free(ptr.ref.tokenShared);
    ptr.ref.tokenShared = nullptr;
    ffi.free(ptr);
  }

  static BtcChainTokenShared fromC(Pointer<clib.CBtcChainTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new BtcChainTokenShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChainTokenShared> toCPtr() {
    var ptr = allocateZero<clib.CBtcChainTokenShared>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcChainTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.tokenShared == null || c.ref.tokenShared == nullptr) {
      c.ref.tokenShared = allocateZero<clib.CTokenShared>();
    }
    tokenShared.toC(c.ref.tokenShared);
  }

  @override
  toDart(Pointer<clib.CBtcChainTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    tokenShared = new TokenShared();
    tokenShared.toDart(c.ref.tokenShared);
  }
}

class ChainShared extends DC<clib.CChainShared> {
  String walletId;
  String chainType;
  Address walletAddress;

  ChainShared() {
    walletAddress = new Address();
  }

  static free(Pointer<clib.CChainShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.walletId != null && ptr.ref.walletId != nullptr) {
      ffi.free(ptr.ref.walletId);
    }
    ptr.ref.walletId = nullptr;
    if (ptr.ref.chainType != null && ptr.ref.chainType != nullptr) {
      ffi.free(ptr.ref.chainType);
    }
    ptr.ref.chainType = nullptr;
    Address.free(ptr.ref.walletAddress);
    ptr.ref.walletAddress = nullptr;
    ffi.free(ptr);
  }

  static ChainShared fromC(Pointer<clib.CChainShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ChainShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CChainShared> toCPtr() {
    var ptr = allocateZero<clib.CChainShared>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CChainShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.walletId != null && c.ref.walletId != nullptr) {
      ffi.free(c.ref.walletId);
    }
    c.ref.walletId = toUtf8Null(walletId);
    if (c.ref.chainType != null && c.ref.chainType != nullptr) {
      ffi.free(c.ref.chainType);
    }
    c.ref.chainType = toUtf8Null(chainType);
    if (c.ref.walletAddress == null || c.ref.walletAddress == nullptr) {
      c.ref.walletAddress = allocateZero<clib.CAddress>();
    }
    walletAddress.toC(c.ref.walletAddress);
  }

  @override
  toDart(Pointer<clib.CChainShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    walletId = fromUtf8Null(c.ref.walletId);
    chainType = fromUtf8Null(c.ref.chainType);
    walletAddress = new Address();
    walletAddress.toDart(c.ref.walletAddress);
  }
}

class ChainVersion extends DC<clib.CChainVersion> {
  String genesisHash;
  int runtimeVersion;
  int txVersion;

  static free(Pointer<clib.CChainVersion> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.genesisHash != null && ptr.ref.genesisHash != nullptr) {
      ffi.free(ptr.ref.genesisHash);
    }
    ptr.ref.genesisHash = nullptr;
    ffi.free(ptr);
  }

  static ChainVersion fromC(Pointer<clib.CChainVersion> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new ChainVersion();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CChainVersion> toCPtr() {
    var ptr = allocateZero<clib.CChainVersion>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CChainVersion> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.genesisHash != null && c.ref.genesisHash != nullptr) {
      ffi.free(c.ref.genesisHash);
    }
    c.ref.genesisHash = toUtf8Null(genesisHash);
    c.ref.runtimeVersion = runtimeVersion;
    c.ref.txVersion = txVersion;
  }

  @override
  toDart(Pointer<clib.CChainVersion> c) {
    if (c == null || c == nullptr) {
      return;
    }
    genesisHash = fromUtf8Null(c.ref.genesisHash);
    runtimeVersion = c.ref.runtimeVersion;
    txVersion = c.ref.txVersion;
  }
}

class Context extends DC<clib.CContext> {
  String id;
  String contextNote;

  static free(Pointer<clib.CContext> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.id != null && ptr.ref.id != nullptr) {
      ffi.free(ptr.ref.id);
    }
    ptr.ref.id = nullptr;
    if (ptr.ref.contextNote != null && ptr.ref.contextNote != nullptr) {
      ffi.free(ptr.ref.contextNote);
    }
    ptr.ref.contextNote = nullptr;
    ffi.free(ptr);
  }

  static Context fromC(Pointer<clib.CContext> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new Context();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CContext> toCPtr() {
    var ptr = allocateZero<clib.CContext>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CContext> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.id != null && c.ref.id != nullptr) {
      ffi.free(c.ref.id);
    }
    c.ref.id = toUtf8Null(id);
    if (c.ref.contextNote != null && c.ref.contextNote != nullptr) {
      ffi.free(c.ref.contextNote);
    }
    c.ref.contextNote = toUtf8Null(contextNote);
  }

  @override
  toDart(Pointer<clib.CContext> c) {
    if (c == null || c == nullptr) {
      return;
    }
    id = fromUtf8Null(c.ref.id);
    contextNote = fromUtf8Null(c.ref.contextNote);
  }
}

class CreateWalletParameters extends DC<clib.CCreateWalletParameters> {
  String name;
  String password;
  String mnemonic;
  String walletType;

  static free(Pointer<clib.CCreateWalletParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.name != null && ptr.ref.name != nullptr) {
      ffi.free(ptr.ref.name);
    }
    ptr.ref.name = nullptr;
    if (ptr.ref.password != null && ptr.ref.password != nullptr) {
      ffi.free(ptr.ref.password);
    }
    ptr.ref.password = nullptr;
    if (ptr.ref.mnemonic != null && ptr.ref.mnemonic != nullptr) {
      ffi.free(ptr.ref.mnemonic);
    }
    ptr.ref.mnemonic = nullptr;
    if (ptr.ref.walletType != null && ptr.ref.walletType != nullptr) {
      ffi.free(ptr.ref.walletType);
    }
    ptr.ref.walletType = nullptr;
    ffi.free(ptr);
  }

  static CreateWalletParameters fromC(
      Pointer<clib.CCreateWalletParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new CreateWalletParameters();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CCreateWalletParameters> toCPtr() {
    var ptr = allocateZero<clib.CCreateWalletParameters>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CCreateWalletParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.name != null && c.ref.name != nullptr) {
      ffi.free(c.ref.name);
    }
    c.ref.name = toUtf8Null(name);
    if (c.ref.password != null && c.ref.password != nullptr) {
      ffi.free(c.ref.password);
    }
    c.ref.password = toUtf8Null(password);
    if (c.ref.mnemonic != null && c.ref.mnemonic != nullptr) {
      ffi.free(c.ref.mnemonic);
    }
    c.ref.mnemonic = toUtf8Null(mnemonic);
    if (c.ref.walletType != null && c.ref.walletType != nullptr) {
      ffi.free(c.ref.walletType);
    }
    c.ref.walletType = toUtf8Null(walletType);
  }

  @override
  toDart(Pointer<clib.CCreateWalletParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    name = fromUtf8Null(c.ref.name);
    password = fromUtf8Null(c.ref.password);
    mnemonic = fromUtf8Null(c.ref.mnemonic);
    walletType = fromUtf8Null(c.ref.walletType);
  }
}

class DbName extends DC<clib.CDbName> {
  String path;
  String prefix;
  String cashboxWallets;
  String cashboxMnemonic;
  String walletMainnet;
  String walletPrivate;
  String walletTestnet;
  String walletTestnetPrivate;

  static free(Pointer<clib.CDbName> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.path != null && ptr.ref.path != nullptr) {
      ffi.free(ptr.ref.path);
    }
    ptr.ref.path = nullptr;
    if (ptr.ref.prefix != null && ptr.ref.prefix != nullptr) {
      ffi.free(ptr.ref.prefix);
    }
    ptr.ref.prefix = nullptr;
    if (ptr.ref.cashboxWallets != null && ptr.ref.cashboxWallets != nullptr) {
      ffi.free(ptr.ref.cashboxWallets);
    }
    ptr.ref.cashboxWallets = nullptr;
    if (ptr.ref.cashboxMnemonic != null && ptr.ref.cashboxMnemonic != nullptr) {
      ffi.free(ptr.ref.cashboxMnemonic);
    }
    ptr.ref.cashboxMnemonic = nullptr;
    if (ptr.ref.walletMainnet != null && ptr.ref.walletMainnet != nullptr) {
      ffi.free(ptr.ref.walletMainnet);
    }
    ptr.ref.walletMainnet = nullptr;
    if (ptr.ref.walletPrivate != null && ptr.ref.walletPrivate != nullptr) {
      ffi.free(ptr.ref.walletPrivate);
    }
    ptr.ref.walletPrivate = nullptr;
    if (ptr.ref.walletTestnet != null && ptr.ref.walletTestnet != nullptr) {
      ffi.free(ptr.ref.walletTestnet);
    }
    ptr.ref.walletTestnet = nullptr;
    if (ptr.ref.walletTestnetPrivate != null &&
        ptr.ref.walletTestnetPrivate != nullptr) {
      ffi.free(ptr.ref.walletTestnetPrivate);
    }
    ptr.ref.walletTestnetPrivate = nullptr;
    ffi.free(ptr);
  }

  static DbName fromC(Pointer<clib.CDbName> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new DbName();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CDbName> toCPtr() {
    var ptr = allocateZero<clib.CDbName>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CDbName> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.path != null && c.ref.path != nullptr) {
      ffi.free(c.ref.path);
    }
    c.ref.path = toUtf8Null(path);
    if (c.ref.prefix != null && c.ref.prefix != nullptr) {
      ffi.free(c.ref.prefix);
    }
    c.ref.prefix = toUtf8Null(prefix);
    if (c.ref.cashboxWallets != null && c.ref.cashboxWallets != nullptr) {
      ffi.free(c.ref.cashboxWallets);
    }
    c.ref.cashboxWallets = toUtf8Null(cashboxWallets);
    if (c.ref.cashboxMnemonic != null && c.ref.cashboxMnemonic != nullptr) {
      ffi.free(c.ref.cashboxMnemonic);
    }
    c.ref.cashboxMnemonic = toUtf8Null(cashboxMnemonic);
    if (c.ref.walletMainnet != null && c.ref.walletMainnet != nullptr) {
      ffi.free(c.ref.walletMainnet);
    }
    c.ref.walletMainnet = toUtf8Null(walletMainnet);
    if (c.ref.walletPrivate != null && c.ref.walletPrivate != nullptr) {
      ffi.free(c.ref.walletPrivate);
    }
    c.ref.walletPrivate = toUtf8Null(walletPrivate);
    if (c.ref.walletTestnet != null && c.ref.walletTestnet != nullptr) {
      ffi.free(c.ref.walletTestnet);
    }
    c.ref.walletTestnet = toUtf8Null(walletTestnet);
    if (c.ref.walletTestnetPrivate != null &&
        c.ref.walletTestnetPrivate != nullptr) {
      ffi.free(c.ref.walletTestnetPrivate);
    }
    c.ref.walletTestnetPrivate = toUtf8Null(walletTestnetPrivate);
  }

  @override
  toDart(Pointer<clib.CDbName> c) {
    if (c == null || c == nullptr) {
      return;
    }
    path = fromUtf8Null(c.ref.path);
    prefix = fromUtf8Null(c.ref.prefix);
    cashboxWallets = fromUtf8Null(c.ref.cashboxWallets);
    cashboxMnemonic = fromUtf8Null(c.ref.cashboxMnemonic);
    walletMainnet = fromUtf8Null(c.ref.walletMainnet);
    walletPrivate = fromUtf8Null(c.ref.walletPrivate);
    walletTestnet = fromUtf8Null(c.ref.walletTestnet);
    walletTestnetPrivate = fromUtf8Null(c.ref.walletTestnetPrivate);
  }
}

class DecodeAccountInfoParameters
    extends DC<clib.CDecodeAccountInfoParameters> {
  String encodeData;
  ChainVersion chainVersion;

  DecodeAccountInfoParameters() {
    chainVersion = new ChainVersion();
  }

  static free(Pointer<clib.CDecodeAccountInfoParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.encodeData != null && ptr.ref.encodeData != nullptr) {
      ffi.free(ptr.ref.encodeData);
    }
    ptr.ref.encodeData = nullptr;
    ChainVersion.free(ptr.ref.chainVersion);
    ptr.ref.chainVersion = nullptr;
    ffi.free(ptr);
  }

  static DecodeAccountInfoParameters fromC(
      Pointer<clib.CDecodeAccountInfoParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new DecodeAccountInfoParameters();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CDecodeAccountInfoParameters> toCPtr() {
    var ptr = allocateZero<clib.CDecodeAccountInfoParameters>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CDecodeAccountInfoParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.encodeData != null && c.ref.encodeData != nullptr) {
      ffi.free(c.ref.encodeData);
    }
    c.ref.encodeData = toUtf8Null(encodeData);
    if (c.ref.chainVersion == null || c.ref.chainVersion == nullptr) {
      c.ref.chainVersion = allocateZero<clib.CChainVersion>();
    }
    chainVersion.toC(c.ref.chainVersion);
  }

  @override
  toDart(Pointer<clib.CDecodeAccountInfoParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    encodeData = fromUtf8Null(c.ref.encodeData);
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.ref.chainVersion);
  }
}

class EeeChain extends DC<clib.CEeeChain> {
  ChainShared chainShared;
  Address address;
  ArrayCEeeChainToken tokens;

  EeeChain() {
    chainShared = new ChainShared();
    address = new Address();
    tokens = new ArrayCEeeChainToken();
  }

  static free(Pointer<clib.CEeeChain> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    ChainShared.free(ptr.ref.chainShared);
    ptr.ref.chainShared = nullptr;
    Address.free(ptr.ref.address);
    ptr.ref.address = nullptr;
    ArrayCEeeChainToken.free(ptr.ref.tokens);
    ptr.ref.tokens = nullptr;
    ffi.free(ptr);
  }

  static EeeChain fromC(Pointer<clib.CEeeChain> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EeeChain();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChain> toCPtr() {
    var ptr = allocateZero<clib.CEeeChain>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChain> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.chainShared == null || c.ref.chainShared == nullptr) {
      c.ref.chainShared = allocateZero<clib.CChainShared>();
    }
    chainShared.toC(c.ref.chainShared);
    if (c.ref.address == null || c.ref.address == nullptr) {
      c.ref.address = allocateZero<clib.CAddress>();
    }
    address.toC(c.ref.address);
    if (c.ref.tokens == null || c.ref.tokens == nullptr) {
      c.ref.tokens = allocateZero<clib.CArrayCEeeChainToken>();
    }
    tokens.toC(c.ref.tokens);
  }

  @override
  toDart(Pointer<clib.CEeeChain> c) {
    if (c == null || c == nullptr) {
      return;
    }
    chainShared = new ChainShared();
    chainShared.toDart(c.ref.chainShared);
    address = new Address();
    address.toDart(c.ref.address);
    tokens = new ArrayCEeeChainToken();
    tokens.toDart(c.ref.tokens);
  }
}

class EeeChainToken extends DC<clib.CEeeChainToken> {
  EeeChainTokenShared eeeChainTokenShared;

  EeeChainToken() {
    eeeChainTokenShared = new EeeChainTokenShared();
  }

  static free(Pointer<clib.CEeeChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    EeeChainTokenShared.free(ptr.ref.eeeChainTokenShared);
    ptr.ref.eeeChainTokenShared = nullptr;
    ffi.free(ptr);
  }

  static EeeChainToken fromC(Pointer<clib.CEeeChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EeeChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainToken> toCPtr() {
    var ptr = allocateZero<clib.CEeeChainToken>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.eeeChainTokenShared == null ||
        c.ref.eeeChainTokenShared == nullptr) {
      c.ref.eeeChainTokenShared = allocateZero<clib.CEeeChainTokenShared>();
    }
    eeeChainTokenShared.toC(c.ref.eeeChainTokenShared);
  }

  @override
  toDart(Pointer<clib.CEeeChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    eeeChainTokenShared = new EeeChainTokenShared();
    eeeChainTokenShared.toDart(c.ref.eeeChainTokenShared);
  }
}

class EeeChainTokenShared extends DC<clib.CEeeChainTokenShared> {
  TokenShared tokenShared;

  EeeChainTokenShared() {
    tokenShared = new TokenShared();
  }

  static free(Pointer<clib.CEeeChainTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    TokenShared.free(ptr.ref.tokenShared);
    ptr.ref.tokenShared = nullptr;
    ffi.free(ptr);
  }

  static EeeChainTokenShared fromC(Pointer<clib.CEeeChainTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EeeChainTokenShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainTokenShared> toCPtr() {
    var ptr = allocateZero<clib.CEeeChainTokenShared>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChainTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.tokenShared == null || c.ref.tokenShared == nullptr) {
      c.ref.tokenShared = allocateZero<clib.CTokenShared>();
    }
    tokenShared.toC(c.ref.tokenShared);
  }

  @override
  toDart(Pointer<clib.CEeeChainTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    tokenShared = new TokenShared();
    tokenShared.toDart(c.ref.tokenShared);
  }
}

class Error extends DC<clib.CError> {
  int code;
  String message;

  static free(Pointer<clib.CError> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.message != null && ptr.ref.message != nullptr) {
      ffi.free(ptr.ref.message);
    }
    ptr.ref.message = nullptr;
    ffi.free(ptr);
  }

  static Error fromC(Pointer<clib.CError> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new Error();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CError> toCPtr() {
    var ptr = allocateZero<clib.CError>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CError> c) {
    if (c == null || c == nullptr) {
      return;
    }
    c.ref.code = code;
    if (c.ref.message != null && c.ref.message != nullptr) {
      ffi.free(c.ref.message);
    }
    c.ref.message = toUtf8Null(message);
  }

  @override
  toDart(Pointer<clib.CError> c) {
    if (c == null || c == nullptr) {
      return;
    }
    code = c.ref.code;
    message = fromUtf8Null(c.ref.message);
  }
}

class EthChain extends DC<clib.CEthChain> {
  ChainShared chainShared;
  ArrayCEthChainToken tokens;

  EthChain() {
    chainShared = new ChainShared();
    tokens = new ArrayCEthChainToken();
  }

  static free(Pointer<clib.CEthChain> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    ChainShared.free(ptr.ref.chainShared);
    ptr.ref.chainShared = nullptr;
    ArrayCEthChainToken.free(ptr.ref.tokens);
    ptr.ref.tokens = nullptr;
    ffi.free(ptr);
  }

  static EthChain fromC(Pointer<clib.CEthChain> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EthChain();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChain> toCPtr() {
    var ptr = allocateZero<clib.CEthChain>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChain> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.chainShared == null || c.ref.chainShared == nullptr) {
      c.ref.chainShared = allocateZero<clib.CChainShared>();
    }
    chainShared.toC(c.ref.chainShared);
    if (c.ref.tokens == null || c.ref.tokens == nullptr) {
      c.ref.tokens = allocateZero<clib.CArrayCEthChainToken>();
    }
    tokens.toC(c.ref.tokens);
  }

  @override
  toDart(Pointer<clib.CEthChain> c) {
    if (c == null || c == nullptr) {
      return;
    }
    chainShared = new ChainShared();
    chainShared.toDart(c.ref.chainShared);
    tokens = new ArrayCEthChainToken();
    tokens.toDart(c.ref.tokens);
  }
}

class EthChainToken extends DC<clib.CEthChainToken> {
  EthChainTokenShared ethChainTokenShared;

  EthChainToken() {
    ethChainTokenShared = new EthChainTokenShared();
  }

  static free(Pointer<clib.CEthChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    EthChainTokenShared.free(ptr.ref.ethChainTokenShared);
    ptr.ref.ethChainTokenShared = nullptr;
    ffi.free(ptr);
  }

  static EthChainToken fromC(Pointer<clib.CEthChainToken> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EthChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainToken> toCPtr() {
    var ptr = allocateZero<clib.CEthChainToken>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.ethChainTokenShared == null ||
        c.ref.ethChainTokenShared == nullptr) {
      c.ref.ethChainTokenShared = allocateZero<clib.CEthChainTokenShared>();
    }
    ethChainTokenShared.toC(c.ref.ethChainTokenShared);
  }

  @override
  toDart(Pointer<clib.CEthChainToken> c) {
    if (c == null || c == nullptr) {
      return;
    }
    ethChainTokenShared = new EthChainTokenShared();
    ethChainTokenShared.toDart(c.ref.ethChainTokenShared);
  }
}

class EthChainTokenShared extends DC<clib.CEthChainTokenShared> {
  TokenShared tokenShared;

  EthChainTokenShared() {
    tokenShared = new TokenShared();
  }

  static free(Pointer<clib.CEthChainTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    TokenShared.free(ptr.ref.tokenShared);
    ptr.ref.tokenShared = nullptr;
    ffi.free(ptr);
  }

  static EthChainTokenShared fromC(Pointer<clib.CEthChainTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new EthChainTokenShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainTokenShared> toCPtr() {
    var ptr = allocateZero<clib.CEthChainTokenShared>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChainTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.tokenShared == null || c.ref.tokenShared == nullptr) {
      c.ref.tokenShared = allocateZero<clib.CTokenShared>();
    }
    tokenShared.toC(c.ref.tokenShared);
  }

  @override
  toDart(Pointer<clib.CEthChainTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    tokenShared = new TokenShared();
    tokenShared.toDart(c.ref.tokenShared);
  }
}

class InitParameters extends DC<clib.CInitParameters> {
  DbName dbName;
  String contextNote;

  InitParameters() {
    dbName = new DbName();
  }

  static free(Pointer<clib.CInitParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    DbName.free(ptr.ref.dbName);
    ptr.ref.dbName = nullptr;
    if (ptr.ref.contextNote != null && ptr.ref.contextNote != nullptr) {
      ffi.free(ptr.ref.contextNote);
    }
    ptr.ref.contextNote = nullptr;
    ffi.free(ptr);
  }

  static InitParameters fromC(Pointer<clib.CInitParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new InitParameters();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CInitParameters> toCPtr() {
    var ptr = allocateZero<clib.CInitParameters>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CInitParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.dbName == null || c.ref.dbName == nullptr) {
      c.ref.dbName = allocateZero<clib.CDbName>();
    }
    dbName.toC(c.ref.dbName);
    if (c.ref.contextNote != null && c.ref.contextNote != nullptr) {
      ffi.free(c.ref.contextNote);
    }
    c.ref.contextNote = toUtf8Null(contextNote);
  }

  @override
  toDart(Pointer<clib.CInitParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    dbName = new DbName();
    dbName.toDart(c.ref.dbName);
    contextNote = fromUtf8Null(c.ref.contextNote);
  }
}

class RawTxParam extends DC<clib.CRawTxParam> {
  String rawTx;
  String walletId;
  String password;

  static free(Pointer<clib.CRawTxParam> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.rawTx != null && ptr.ref.rawTx != nullptr) {
      ffi.free(ptr.ref.rawTx);
    }
    ptr.ref.rawTx = nullptr;
    if (ptr.ref.walletId != null && ptr.ref.walletId != nullptr) {
      ffi.free(ptr.ref.walletId);
    }
    ptr.ref.walletId = nullptr;
    if (ptr.ref.password != null && ptr.ref.password != nullptr) {
      ffi.free(ptr.ref.password);
    }
    ptr.ref.password = nullptr;
    ffi.free(ptr);
  }

  static RawTxParam fromC(Pointer<clib.CRawTxParam> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new RawTxParam();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CRawTxParam> toCPtr() {
    var ptr = allocateZero<clib.CRawTxParam>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CRawTxParam> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.rawTx != null && c.ref.rawTx != nullptr) {
      ffi.free(c.ref.rawTx);
    }
    c.ref.rawTx = toUtf8Null(rawTx);
    if (c.ref.walletId != null && c.ref.walletId != nullptr) {
      ffi.free(c.ref.walletId);
    }
    c.ref.walletId = toUtf8Null(walletId);
    if (c.ref.password != null && c.ref.password != nullptr) {
      ffi.free(c.ref.password);
    }
    c.ref.password = toUtf8Null(password);
  }

  @override
  toDart(Pointer<clib.CRawTxParam> c) {
    if (c == null || c == nullptr) {
      return;
    }
    rawTx = fromUtf8Null(c.ref.rawTx);
    walletId = fromUtf8Null(c.ref.walletId);
    password = fromUtf8Null(c.ref.password);
  }
}

class StorageKeyParameters extends DC<clib.CStorageKeyParameters> {
  ChainVersion chainVersion;
  String module;
  String storageItem;
  String pubKey;

  StorageKeyParameters() {
    chainVersion = new ChainVersion();
  }

  static free(Pointer<clib.CStorageKeyParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    ChainVersion.free(ptr.ref.chainVersion);
    ptr.ref.chainVersion = nullptr;
    if (ptr.ref.module != null && ptr.ref.module != nullptr) {
      ffi.free(ptr.ref.module);
    }
    ptr.ref.module = nullptr;
    if (ptr.ref.storageItem != null && ptr.ref.storageItem != nullptr) {
      ffi.free(ptr.ref.storageItem);
    }
    ptr.ref.storageItem = nullptr;
    if (ptr.ref.pubKey != null && ptr.ref.pubKey != nullptr) {
      ffi.free(ptr.ref.pubKey);
    }
    ptr.ref.pubKey = nullptr;
    ffi.free(ptr);
  }

  static StorageKeyParameters fromC(Pointer<clib.CStorageKeyParameters> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new StorageKeyParameters();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CStorageKeyParameters> toCPtr() {
    var ptr = allocateZero<clib.CStorageKeyParameters>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CStorageKeyParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.chainVersion == null || c.ref.chainVersion == nullptr) {
      c.ref.chainVersion = allocateZero<clib.CChainVersion>();
    }
    chainVersion.toC(c.ref.chainVersion);
    if (c.ref.module != null && c.ref.module != nullptr) {
      ffi.free(c.ref.module);
    }
    c.ref.module = toUtf8Null(module);
    if (c.ref.storageItem != null && c.ref.storageItem != nullptr) {
      ffi.free(c.ref.storageItem);
    }
    c.ref.storageItem = toUtf8Null(storageItem);
    if (c.ref.pubKey != null && c.ref.pubKey != nullptr) {
      ffi.free(c.ref.pubKey);
    }
    c.ref.pubKey = toUtf8Null(pubKey);
  }

  @override
  toDart(Pointer<clib.CStorageKeyParameters> c) {
    if (c == null || c == nullptr) {
      return;
    }
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.ref.chainVersion);
    module = fromUtf8Null(c.ref.module);
    storageItem = fromUtf8Null(c.ref.storageItem);
    pubKey = fromUtf8Null(c.ref.pubKey);
  }
}

class SubChainBasicInfo extends DC<clib.CSubChainBasicInfo> {
  String genesisHash;
  String metadata;
  int runtimeVersion;
  int txVersion;
  int ss58FormatPrefix;
  int tokenDecimals;
  String tokenSymbol;
  int isDefault;

  static free(Pointer<clib.CSubChainBasicInfo> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.genesisHash != null && ptr.ref.genesisHash != nullptr) {
      ffi.free(ptr.ref.genesisHash);
    }
    ptr.ref.genesisHash = nullptr;
    if (ptr.ref.metadata != null && ptr.ref.metadata != nullptr) {
      ffi.free(ptr.ref.metadata);
    }
    ptr.ref.metadata = nullptr;
    if (ptr.ref.tokenSymbol != null && ptr.ref.tokenSymbol != nullptr) {
      ffi.free(ptr.ref.tokenSymbol);
    }
    ptr.ref.tokenSymbol = nullptr;
    ffi.free(ptr);
  }

  static SubChainBasicInfo fromC(Pointer<clib.CSubChainBasicInfo> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new SubChainBasicInfo();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CSubChainBasicInfo> toCPtr() {
    var ptr = allocateZero<clib.CSubChainBasicInfo>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CSubChainBasicInfo> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.genesisHash != null && c.ref.genesisHash != nullptr) {
      ffi.free(c.ref.genesisHash);
    }
    c.ref.genesisHash = toUtf8Null(genesisHash);
    if (c.ref.metadata != null && c.ref.metadata != nullptr) {
      ffi.free(c.ref.metadata);
    }
    c.ref.metadata = toUtf8Null(metadata);
    c.ref.runtimeVersion = runtimeVersion;
    c.ref.txVersion = txVersion;
    c.ref.ss58FormatPrefix = ss58FormatPrefix;
    c.ref.tokenDecimals = tokenDecimals;
    if (c.ref.tokenSymbol != null && c.ref.tokenSymbol != nullptr) {
      ffi.free(c.ref.tokenSymbol);
    }
    c.ref.tokenSymbol = toUtf8Null(tokenSymbol);
    c.ref.isDefault = isDefault;
  }

  @override
  toDart(Pointer<clib.CSubChainBasicInfo> c) {
    if (c == null || c == nullptr) {
      return;
    }
    genesisHash = fromUtf8Null(c.ref.genesisHash);
    metadata = fromUtf8Null(c.ref.metadata);
    runtimeVersion = c.ref.runtimeVersion;
    txVersion = c.ref.txVersion;
    ss58FormatPrefix = c.ref.ss58FormatPrefix;
    tokenDecimals = c.ref.tokenDecimals;
    tokenSymbol = fromUtf8Null(c.ref.tokenSymbol);
    isDefault = c.ref.isDefault;
  }
}

class TokenShared extends DC<clib.CTokenShared> {
  String name;
  String symbol;
  String logoUrl;
  String logoBytes;
  String projectName;
  String projectHome;
  String projectNote;

  static free(Pointer<clib.CTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.name != null && ptr.ref.name != nullptr) {
      ffi.free(ptr.ref.name);
    }
    ptr.ref.name = nullptr;
    if (ptr.ref.symbol != null && ptr.ref.symbol != nullptr) {
      ffi.free(ptr.ref.symbol);
    }
    ptr.ref.symbol = nullptr;
    if (ptr.ref.logoUrl != null && ptr.ref.logoUrl != nullptr) {
      ffi.free(ptr.ref.logoUrl);
    }
    ptr.ref.logoUrl = nullptr;
    if (ptr.ref.logoBytes != null && ptr.ref.logoBytes != nullptr) {
      ffi.free(ptr.ref.logoBytes);
    }
    ptr.ref.logoBytes = nullptr;
    if (ptr.ref.projectName != null && ptr.ref.projectName != nullptr) {
      ffi.free(ptr.ref.projectName);
    }
    ptr.ref.projectName = nullptr;
    if (ptr.ref.projectHome != null && ptr.ref.projectHome != nullptr) {
      ffi.free(ptr.ref.projectHome);
    }
    ptr.ref.projectHome = nullptr;
    if (ptr.ref.projectNote != null && ptr.ref.projectNote != nullptr) {
      ffi.free(ptr.ref.projectNote);
    }
    ptr.ref.projectNote = nullptr;
    ffi.free(ptr);
  }

  static TokenShared fromC(Pointer<clib.CTokenShared> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new TokenShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CTokenShared> toCPtr() {
    var ptr = allocateZero<clib.CTokenShared>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.name != null && c.ref.name != nullptr) {
      ffi.free(c.ref.name);
    }
    c.ref.name = toUtf8Null(name);
    if (c.ref.symbol != null && c.ref.symbol != nullptr) {
      ffi.free(c.ref.symbol);
    }
    c.ref.symbol = toUtf8Null(symbol);
    if (c.ref.logoUrl != null && c.ref.logoUrl != nullptr) {
      ffi.free(c.ref.logoUrl);
    }
    c.ref.logoUrl = toUtf8Null(logoUrl);
    if (c.ref.logoBytes != null && c.ref.logoBytes != nullptr) {
      ffi.free(c.ref.logoBytes);
    }
    c.ref.logoBytes = toUtf8Null(logoBytes);
    if (c.ref.projectName != null && c.ref.projectName != nullptr) {
      ffi.free(c.ref.projectName);
    }
    c.ref.projectName = toUtf8Null(projectName);
    if (c.ref.projectHome != null && c.ref.projectHome != nullptr) {
      ffi.free(c.ref.projectHome);
    }
    c.ref.projectHome = toUtf8Null(projectHome);
    if (c.ref.projectNote != null && c.ref.projectNote != nullptr) {
      ffi.free(c.ref.projectNote);
    }
    c.ref.projectNote = toUtf8Null(projectNote);
  }

  @override
  toDart(Pointer<clib.CTokenShared> c) {
    if (c == null || c == nullptr) {
      return;
    }
    name = fromUtf8Null(c.ref.name);
    symbol = fromUtf8Null(c.ref.symbol);
    logoUrl = fromUtf8Null(c.ref.logoUrl);
    logoBytes = fromUtf8Null(c.ref.logoBytes);
    projectName = fromUtf8Null(c.ref.projectName);
    projectHome = fromUtf8Null(c.ref.projectHome);
    projectNote = fromUtf8Null(c.ref.projectNote);
  }
}

class TransferPayload extends DC<clib.CTransferPayload> {
  String fromAccount;
  String toAccount;
  String value;
  int index;
  ChainVersion chainVersion;
  String extData;
  String password;

  TransferPayload() {
    chainVersion = new ChainVersion();
  }

  static free(Pointer<clib.CTransferPayload> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.fromAccount != null && ptr.ref.fromAccount != nullptr) {
      ffi.free(ptr.ref.fromAccount);
    }
    ptr.ref.fromAccount = nullptr;
    if (ptr.ref.toAccount != null && ptr.ref.toAccount != nullptr) {
      ffi.free(ptr.ref.toAccount);
    }
    ptr.ref.toAccount = nullptr;
    if (ptr.ref.value != null && ptr.ref.value != nullptr) {
      ffi.free(ptr.ref.value);
    }
    ptr.ref.value = nullptr;
    ChainVersion.free(ptr.ref.chainVersion);
    ptr.ref.chainVersion = nullptr;
    if (ptr.ref.extData != null && ptr.ref.extData != nullptr) {
      ffi.free(ptr.ref.extData);
    }
    ptr.ref.extData = nullptr;
    if (ptr.ref.password != null && ptr.ref.password != nullptr) {
      ffi.free(ptr.ref.password);
    }
    ptr.ref.password = nullptr;
    ffi.free(ptr);
  }

  static TransferPayload fromC(Pointer<clib.CTransferPayload> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new TransferPayload();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CTransferPayload> toCPtr() {
    var ptr = allocateZero<clib.CTransferPayload>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CTransferPayload> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.fromAccount != null && c.ref.fromAccount != nullptr) {
      ffi.free(c.ref.fromAccount);
    }
    c.ref.fromAccount = toUtf8Null(fromAccount);
    if (c.ref.toAccount != null && c.ref.toAccount != nullptr) {
      ffi.free(c.ref.toAccount);
    }
    c.ref.toAccount = toUtf8Null(toAccount);
    if (c.ref.value != null && c.ref.value != nullptr) {
      ffi.free(c.ref.value);
    }
    c.ref.value = toUtf8Null(value);
    c.ref.index = index;
    if (c.ref.chainVersion == null || c.ref.chainVersion == nullptr) {
      c.ref.chainVersion = allocateZero<clib.CChainVersion>();
    }
    chainVersion.toC(c.ref.chainVersion);
    if (c.ref.extData != null && c.ref.extData != nullptr) {
      ffi.free(c.ref.extData);
    }
    c.ref.extData = toUtf8Null(extData);
    if (c.ref.password != null && c.ref.password != nullptr) {
      ffi.free(c.ref.password);
    }
    c.ref.password = toUtf8Null(password);
  }

  @override
  toDart(Pointer<clib.CTransferPayload> c) {
    if (c == null || c == nullptr) {
      return;
    }
    fromAccount = fromUtf8Null(c.ref.fromAccount);
    toAccount = fromUtf8Null(c.ref.toAccount);
    value = fromUtf8Null(c.ref.value);
    index = c.ref.index;
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.ref.chainVersion);
    extData = fromUtf8Null(c.ref.extData);
    password = fromUtf8Null(c.ref.password);
  }
}

class Wallet extends DC<clib.CWallet> {
  String id;
  String nextId;
  String name;
  EthChain ethChain;
  EeeChain eeeChain;
  BtcChain btcChain;

  Wallet() {
    ethChain = new EthChain();
    eeeChain = new EeeChain();
    btcChain = new BtcChain();
  }

  static free(Pointer<clib.CWallet> ptr) {
    if (ptr == null || ptr == nullptr) {
      return;
    }
    if (ptr.ref.id != null && ptr.ref.id != nullptr) {
      ffi.free(ptr.ref.id);
    }
    ptr.ref.id = nullptr;
    if (ptr.ref.nextId != null && ptr.ref.nextId != nullptr) {
      ffi.free(ptr.ref.nextId);
    }
    ptr.ref.nextId = nullptr;
    if (ptr.ref.name != null && ptr.ref.name != nullptr) {
      ffi.free(ptr.ref.name);
    }
    ptr.ref.name = nullptr;
    EthChain.free(ptr.ref.ethChain);
    ptr.ref.ethChain = nullptr;
    EeeChain.free(ptr.ref.eeeChain);
    ptr.ref.eeeChain = nullptr;
    BtcChain.free(ptr.ref.btcChain);
    ptr.ref.btcChain = nullptr;
    ffi.free(ptr);
  }

  static Wallet fromC(Pointer<clib.CWallet> ptr) {
    if (ptr == null || ptr == nullptr) {
      return null;
    }
    var d = new Wallet();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CWallet> toCPtr() {
    var ptr = allocateZero<clib.CWallet>();
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CWallet> c) {
    if (c == null || c == nullptr) {
      return;
    }
    if (c.ref.id != null && c.ref.id != nullptr) {
      ffi.free(c.ref.id);
    }
    c.ref.id = toUtf8Null(id);
    if (c.ref.nextId != null && c.ref.nextId != nullptr) {
      ffi.free(c.ref.nextId);
    }
    c.ref.nextId = toUtf8Null(nextId);
    if (c.ref.name != null && c.ref.name != nullptr) {
      ffi.free(c.ref.name);
    }
    c.ref.name = toUtf8Null(name);
    if (c.ref.ethChain == null || c.ref.ethChain == nullptr) {
      c.ref.ethChain = allocateZero<clib.CEthChain>();
    }
    ethChain.toC(c.ref.ethChain);
    if (c.ref.eeeChain == null || c.ref.eeeChain == nullptr) {
      c.ref.eeeChain = allocateZero<clib.CEeeChain>();
    }
    eeeChain.toC(c.ref.eeeChain);
    if (c.ref.btcChain == null || c.ref.btcChain == nullptr) {
      c.ref.btcChain = allocateZero<clib.CBtcChain>();
    }
    btcChain.toC(c.ref.btcChain);
  }

  @override
  toDart(Pointer<clib.CWallet> c) {
    if (c == null || c == nullptr) {
      return;
    }
    id = fromUtf8Null(c.ref.id);
    nextId = fromUtf8Null(c.ref.nextId);
    name = fromUtf8Null(c.ref.name);
    ethChain = new EthChain();
    ethChain.toDart(c.ref.ethChain);
    eeeChain = new EeeChain();
    eeeChain.toDart(c.ref.eeeChain);
    btcChain = new BtcChain();
    btcChain.toDart(c.ref.btcChain);
  }
}
