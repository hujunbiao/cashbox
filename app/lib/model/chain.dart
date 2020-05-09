import 'dart:typed_data';

import 'package:wallet_manager/wallet_manager.dart';

import 'digit.dart';

enum ChainType { UNKNOWN, BTC, BTC_TEST, ETH, ETH_TEST, EEE, EEE_TEST } /*标记：定义需要与JNI处保持一致*/

abstract class Chain {
  String chainId; //链Id
  String walletId; //钱包Id
  String chainAddress; //链地址
  List<Digit> digitsList = [];
  bool isVisible = true; //默认链可见
  ChainType chainType;

  static String chainTypeToValue(ChainType chainType) {
    switch (chainType) {
      case ChainType.BTC:
        return "BTC";
      case ChainType.BTC_TEST:
        return "BTC_TEST";
      case ChainType.ETH:
        return "ETH";
      case ChainType.ETH_TEST:
        return "ETH_TEST";
      case ChainType.EEE:
        return "EEE";
      case ChainType.EEE_TEST:
        return "EEE_TEST";
      default:
        return ""; //UNKNOWN
    }
  }

  //跟jni接口处，定义一致  NativeLib.ChainType
  static int chainTypeToInt(ChainType chainType) {
    switch (chainType) {
      case ChainType.BTC:
        return 1;
      case ChainType.BTC_TEST:
        return 2;
      case ChainType.ETH:
        return 3;
      case ChainType.ETH_TEST:
        return 4;
      case ChainType.EEE:
        return 5;
      case ChainType.EEE_TEST:
        return 6;
      default:
        return 0;
    }
  }

  static ChainType intToChainType(int chainTypeInt) {
    ChainType chainType;
    switch (chainTypeInt) {
      /*标记：定义需要与JNI处保持一致*/
      case 1:
        chainType = ChainType.BTC;
        break;
      case 2:
        chainType = ChainType.BTC_TEST;
        break;
      case 3:
        chainType = ChainType.ETH;
        break;
      case 4:
        chainType = ChainType.ETH_TEST;
        break;
      case 5:
        chainType = ChainType.EEE;
        break;
      case 6:
        chainType = ChainType.EEE_TEST;
        break;
      default:
        chainType = ChainType.UNKNOWN;
    }
    return chainType;
  }

  // 显示代币
  // apiNo:WM14
  Future<bool> showDigit(Digit digit) async {
    Map showDigitMap = await WalletManager.showDigit(walletId, chainId, digit.digitId);
    int status = showDigitMap["status"];
    if (status == 200) {
      digit.isVisible = true;
      return true; //执行成功
    }
    return false; //执行失败
  }

  // 隐藏代币
  // apiNo:WM15
  Future<bool> hideDigit(Digit digit) async {
    Map hideDigitMap = await WalletManager.hideDigit(walletId, chainId, digit.digitId);
    int status = hideDigitMap["status"];
    if (status == 200) {
      digit.isVisible = false;
      return true; //执行成功
    }
    return false;
  }

  // 添加代币 todo 2.0 待确定数据格式
  Future<bool> addDigit(Digit digit) async {
    digitsList.add(digit);
    //todo 数据格式
    /*    var isSuccess = await WalletManager.addDigit(
        digit.digitId,
        digit.chainId,
        digit.address,
        digit.balance,
        digit.contractAddress,
        digit.shortName,
        digit.fullName,
        digit.decimal);
    if (isSuccess) {
      digitsList.add(digit);
    }*/
    return null;
  }

  // 添加代币list todo 2.0 待确定数据格式
  Future<bool> addDigitList(List<Digit> digitList) async {
    //todo db操作 原子性
    var isSuccess = await WalletManager.addDigitList(digitList);
    if (isSuccess) {
      digitsList.addAll(digitList);
    }
    return isSuccess;
  }

  // 删除代币 todo 2.0 待确定数据格式
  Future<bool> deleteDigit(digit) async {
    //todo db操作 原子性
    var isSuccess = await WalletManager.deleteDigit(digit);
    if (isSuccess) {
      digitsList.remove(digit);
    }
    return isSuccess;
  }
}

class ChainETH extends Chain {}

class ChainBTC extends Chain {
  ChainBTC(chainId, walletId) {
    this.chainId = chainId;
    this.walletId = walletId;
  }

  @override
  ChainType get chainType => ChainType.BTC;
}

class ChainEEE extends Chain {
  Future<Map<dynamic, dynamic>> eeeEnergyTransfer(String from, Uint8List pwd, String to, String value, String extendMsg) async {
    Map map = await WalletManager.eeeEnergyTransfer(from, pwd, to, value, extendMsg);
    print("map");
    return map;
  }
}
