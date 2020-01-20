import 'package:flutter/foundation.dart';

class TransactionProvide with ChangeNotifier {
  String _toAddress;
  String _txValue;
  String _backup;
  String _digitName;
  String _fromAddress;
  String _gas;
  String _gasPrice;
  String _timeStamp;
  String _nonce;
  String _hash;
  String _contractAddress;
  String _cumulativeGasUsed;
  String _gasUsed;
  String _confirmations;

  void empty() {
    _toAddress = "";
    _txValue = "";
    _backup = "";
    _digitName = "";
    _fromAddress = "";
    _gas = "";
    _gasPrice = "";
    _timeStamp = "";
    _nonce = "";
  }

  String get fromAddress => _fromAddress;

  void setFromAddress(String value) {
    _fromAddress = value;
  }

  String get nonce => _nonce;

  setNonce(String value) {
    _nonce = value;
  }

  String get gas => _gas;

  void setGas(String value) {
    _gas = value;
  }

  String get digitName => _digitName;

  void setDigitName(String value) {
    _digitName = value;
  }

  String get toAddress => _toAddress;

  void setToAddress(String value) {
    _toAddress = value;
  }

  String get txValue => _txValue;

  void setValue(String value) {
    _txValue = value;
  }

  String get backup => _backup;

  void setBackup(String value) {
    _backup = value;
  }

  String get gasPrice => _gasPrice;

  setGasPrice(String value) {
    _gasPrice = value;
  }

  String get timeStamp => _timeStamp;

  setTimeStamp(String value) {
    _timeStamp = value;
  }

  String get hash => _hash;

  setHash(String value) {
    _hash = value;
  }

  String get contractAddress => _contractAddress;

  setContractAddress(String value) {
    _contractAddress = value;
  }

  String get cumulativeGasUsed => _cumulativeGasUsed;

  setCumulativeGasUsed(String value) {
    _cumulativeGasUsed = value;
  }

  String get gasUsed => _gasUsed;

  setGasUsed(String value) {
    _gasUsed = value;
  }

  String get confirmations => _confirmations;

  setConfirmations(String value) {
    _confirmations = value;
  }
}
