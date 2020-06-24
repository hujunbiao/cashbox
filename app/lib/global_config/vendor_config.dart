/*
  配置文件
  开发者可根据自己需要，增、删各个功能的接口接口数据。
  例如：可增加对应后端法币接口等
**/
class VendorConfig {
  static const RatePath = "";
  static const versionCheckIp = ""; //版本检查接口；
  static const latestVersionIp = ""; //最新版本app下载接口；

  static const rateDigitIpKey = ""; //代币对应的法币key
  static const rateDigitIpDefaultValue = ""; //代币对应的法币接口ip；

  static const authDigitsVersionKey = ""; //可信任代币的版本号key
  static const authDigitsVersionValue = ""; //可信任代币的版本号value

  static const authDigitsIpKey = ""; //可信erc代币列表key
  static const authDigitsIpDefaultValue = ""; //可信erc代币列表；

  static const defaultDigitsKey = ""; //默认代币ip对应key；
  static const defaultDigitsDefaultValue = ""; //默认代币ip对应的值；

  static const scryXIpKey = ""; //默认语言中文；
  static const scryXIpDefaultValue = "";

  static const cashboxDownloadIpKey = ""; //
  static const cashboxDownloadIpDefaultValue = ""; //

  static const publicIpKey = "";
  static const publicIpDefaultValue = "";

  static const ETHERSCAN_API_KEY = "";
}

const DddMainNetContractAddress = "";
const DddTestNetContractAddress = "";