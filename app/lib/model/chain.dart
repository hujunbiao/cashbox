import 'dart:typed_data';

import 'package:wallet_manager/wallet_manager.dart';

import 'digit.dart';

enum ChainType { UNKNOWN, BTC, BTC_TEST, ETH, ETH_TEST, EEE, EEE_TEST } /*标记：定义需要与JNI处保持一致*/

abstract class Chain {
  String chainId; //链Id
  String walletId; //钱包Id
  String chainAddress; //链地址
  List<Digit> digitsList = [];
  List<Digit> visibleDigitsList = []; //可见代币列表：digit.isVisible = true类型
  bool isVisible = true; //默认链可见
  ChainType chainType;

  List<Digit> getVisibleDigitList() {
    var tempList = this.digitsList.map((e) => e).toList();
    tempList.retainWhere((element) {
      return element.isVisible;
    });
    return tempList;
  }

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
    print("showDigit    walletId===>" + walletId + "||chainId===>" + chainId + "||digit.digitId" + digit.digitId);
    Map showDigitMap = await WalletManager.showDigit(walletId, chainId, digit.digitId);
    int status = showDigitMap["status"];
    bool isShowDigit = showDigitMap["isShowDigit"];
    if (status == 200) {
      if (isShowDigit) {
        //执行成功
        digit.isVisible = true;
        return isShowDigit;
      }
    }
    return false; //执行失败
  }

  // 隐藏代币
  // apiNo:WM15
  Future<bool> hideDigit(Digit digit) async {
    print("hideDigit        walletId===>" + walletId + "||chainId===>" + chainId + "||digit.digitId" + digit.digitId);
    Map hideDigitMap = await WalletManager.hideDigit(walletId, chainId, digit.digitId);
    int status = hideDigitMap["status"];
    bool isHideDigit = hideDigitMap["isHideDigit"];
    if (status == 200) {
      if (isHideDigit == true) {
        digit.isVisible = false;
        return isHideDigit; //执行成功
      }
    }
    return false;
  }

  // 添加代币 todo 2.0 待确定数据格式
  Future<bool> addDigit(String walletId, Digit digit) async {
    Map addDigitMap = await WalletManager.addDigit(walletId, digit.chainId, digit.fullName, digit.shortName, digit.contractAddress, digit.decimal);
    int status = addDigitMap["status"];
    bool isAddDigit = addDigitMap["isAddDigit"];
    if (status == 200) {
      if (isAddDigit) {
        digitsList.add(digit);
        return isAddDigit;
      }
    }
    return false;
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
