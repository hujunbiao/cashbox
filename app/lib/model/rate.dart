import 'package:app/model/digit.dart';

class Rate {
  static Rate get instance => _getInstance();
  static Rate _instance; //private

  static _getInstance() {
    if (_instance == null) {
      _instance = new Rate._internal();
      return _instance;
    }
    return _instance;
  }

  Rate._internal() {
    // Initializable parameters
  }

  Map<String, DigitRate> digitRateMap = Map<String, DigitRate>();
  Map legalMap = Map<String, double>();
  String nowLegalCurrency = "USD";

  setDigitRateMap(Map digitRateMap) {
    this.digitRateMap = digitRateMap;
  }

  setLegalMap(map) {
    this.legalMap = map;
  }

  List<String> getAllSupportLegalCurrency() {
    return List.from(this.legalMap.keys);
  }

  setNowLegalCurrency(String nowLegalCurrency) {
    this.nowLegalCurrency = nowLegalCurrency;
  }

  String getNowLegalCurrency() {
    return this.nowLegalCurrency;
  }

  getNowLegalCurrencyRate() {
    return this.legalMap[this.nowLegalCurrency];
  }

  double getChangeDaily(Digit digit) {
    if (!digitRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return 0.0;
    }
    return this.digitRateMap[digit.shortName.trim().toUpperCase()].changeDaily;
  }

  String getName(Digit digit) {
    if (!digitRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return "";
    }
    return this.digitRateMap[digit.shortName.trim().toUpperCase()].name;
  }

  String getSymbol(Digit digit) {
    if (!digitRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return "";
    }
    return this.digitRateMap[digit.shortName.trim().toUpperCase()].symbol;
  }

  double getPrice(Digit digit) {
    //Unit price corresponding to fiat currency
    if (!digitRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return 0.0;
    }
    return instance.digitRateMap[digit.shortName.trim().toUpperCase()].price * instance.legalMap[getNowLegalCurrency()];
    //return instance.digitRateMap[digit.shortName.toUpperCase()]["price"] * instance.legalMap[getNowLegalCurrency()];
  }

  double getMoney(Digit digit) {
    if (digit.balance == null || digit.balance.trim() == "") {
      return 0.0;
    }
    return getPrice(digit) * double.parse(digit.balance);
  }

  double getHigh(Digit digit) {
    if (!digitRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return 0.0;
    }
    return instance.digitRateMap[digit.shortName.trim().toUpperCase()].high;
    //return instance.digitRateMap[digit.shortName.toUpperCase()]["high"];
  }

  double getLow(Digit digit) {
    if (!digitRateMap.containsKey(digit.shortName.trim().toUpperCase())) {
      return 0.0;
    }
    return instance.digitRateMap[digit.shortName.trim().toUpperCase()].low;
    //return instance.digitRateMap[digit.shortName.toUpperCase()]["low"];
  }
}

//API returns the model format is consistent
class DigitRate {
  String name = "";
  String symbol = "";
  double price = 0.0;
  double high = 0.0;
  double low = 0.0;
  double histHigh = 0.0;
  double histLow = 0.0;
  int timestamps = 0;
  double volume = 0;
  double changeDaily = 0.00;

  String get getChangeDaily {
    if (changeDaily >= 0) {
      return (changeDaily * 100.0).toStringAsFixed(5) + "%" + "↑";
    }
    return (changeDaily * 100.0).toStringAsFixed(5) + "%" + "↓";
  }
}
