import 'package:app/configv/config/config.dart';
import 'package:app/configv/config/handle_config.dart';
import 'package:app/model/wallets.dart';
import 'package:logger/logger.dart';
import 'net_util.dart';

class ScryXNetUtil {
  //todo 待优化
  Future<String> _loadScryXIp() async {
    Config config = await HandleConfig.instance.getConfig();
    return config.privateConfig.scryXIp;
    // return "http://192.168.2.7:9933";
  }

  Future<Map> loadEeeChainNonceTest(String fromAddress) async {
    String netUrl = await _loadScryXIp();
    Map resultMap = new Map();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "system_accountNextIndex",
      "params": [fromAddress],
      "id": 21,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      Logger().e("loadEeeChainNonceTest error is  ", e.toString());
      return null;
    }
  }

  Future<int> loadEeeChainNonce(String module, String storageItem, String pubKey) async {
    int eeeNonce = 0;
    Map eeeResultMap = await loadEeeStorageMap(module, storageItem, pubKey);
    if (eeeResultMap != null && eeeResultMap.containsKey("nonce")) {
      return eeeResultMap["nonce"];
    }
    return eeeNonce;
  }

  Future<String> loadEeeBalance(String module, String storageItem, String pubKey) async {
    String eeeBalance = "0";
    Map eeeResultMap = await loadEeeStorageMap(module, storageItem, pubKey);
    if (eeeResultMap != null && eeeResultMap.containsKey("free")) {
      return eeeResultMap["free"];
    }
    return eeeBalance;
  }

  Future<Map> loadEeeStorageMap(String module, String storageItem, String accountStr) async {
    Map eeeResultMap;
    String storageKey = await loadEeeStorageKey(module, storageItem, accountStr);
    if (storageKey != null && storageKey.trim() != "") {
      Map netFormatMap = await _loadScryXStorage(storageKey);
      if (netFormatMap != null && netFormatMap.containsKey("result") && netFormatMap["result"] != null) {
        eeeResultMap = await Wallets.instance.decodeEeeAccountInfo(netFormatMap["result"]);
      }
    }
    return eeeResultMap;
  }

  Future<String> loadEeeStorageKey(String module, String storageItem, String accountStr) async {
    Map<dynamic, dynamic> eeeStorageKeyMap = await Wallets.instance.eeeStorageKey(module, storageItem, accountStr);
    if (eeeStorageKeyMap != null && eeeStorageKeyMap.containsKey("status")) {
      if (eeeStorageKeyMap["status"] != null && eeeStorageKeyMap["status"] == 200 && eeeStorageKeyMap.containsKey("storageKeyInfo")) {
        return eeeStorageKeyMap["storageKeyInfo"];
      }
    }
    return null;
  }

  Future<Map> loadTokenXbalance(String tokenx, String balances, String accountStr) async {
    Map tokenXResultMap;
    Map<dynamic, dynamic> eeeStorageKeyMap = await Wallets.instance.eeeStorageKey(tokenx, balances, accountStr);
    if (eeeStorageKeyMap != null && eeeStorageKeyMap.containsKey("status")) {
      if (eeeStorageKeyMap["status"] != null && eeeStorageKeyMap["status"] == 200 && eeeStorageKeyMap.containsKey("storageKeyInfo")) {
        String storageKeyInfo = eeeStorageKeyMap["storageKeyInfo"];
        Map netFormatMap = await _loadScryXStorage(storageKeyInfo);
        if (netFormatMap != null && netFormatMap.containsKey("result")) {
          return netFormatMap;
        }
      }
    }
    return tokenXResultMap;
  }

  Future<Map> _loadScryXStorage(formattedAddress) async {
    String netUrl = await _loadScryXIp();
    Map resultMap = new Map();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "state_getStorage",
      "params": [formattedAddress],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      Logger().e("loadScryXStorage error is  ", e.toString());
      return null;
    }
  }

  Future<Map> loadScryXRuntimeVersion() async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {"method": "state_getRuntimeVersion", "params": [], "id": 1, "jsonrpc": "2.0"};
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      Logger().e("loadScryXRuntimeVersion error is  ", e.toString());
      return null;
    }
  }

  Future<Map> loadScryXBlockHash() async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "chain_getBlockHash",
      "params": [0],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      Logger().e("loadScryXBlockHash error is  ", e.toString());
      return null;
    }
  }

  Future<Map> loadChainHeader() async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {"method": "chain_getHeader", "params": [], "id": 1, "jsonrpc": "2.0"};
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      Logger().e("loadChainHeader error is  ", e.toString());
      return null;
    }
  }

  Future<Map> loadChainBlockHash(int endBlockHeight) async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "chain_getBlockHash",
      "params": [endBlockHeight],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      return null;
    }
  }

  Future<Map> loadQueryStorage(List<String> accountKeyInfo, String startBlockHash, String endBlockHash) async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "state_queryStorage",
      "params": [accountKeyInfo, startBlockHash, endBlockHash],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      return null;
    }
  }

  Future<Map> loadBlock(String blockHash) async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "chain_getBlock",
      "params": [blockHash],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      return null;
    }
  }

  Future<Map> loadStateStorage(String eventKeyPrefix, String blockHash) async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "state_getStorage",
      "params": [eventKeyPrefix, blockHash],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      return null;
    }
  }

  Future<Map> submitExtrinsic(txInfo) async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {
      "method": "author_submitExtrinsic", // author_submitExtrinsic
      "params": [txInfo],
      "id": 1,
      "jsonrpc": "2.0"
    };
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      Logger().e("submitExtrinsic error is  ", e.toString());
      return null;
    }
  }

  Future<Map> loadMetadata() async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {"method": "state_getMetadata", "params": [], "id": 1, "jsonrpc": "2.0"};
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      Logger().e("getMetadata error is  ", e.toString());
      return null;
    }
  }

  Future<Map> loadSystemProperties() async {
    Map resultMap = new Map();
    String netUrl = await _loadScryXIp();
    if (netUrl == null || netUrl.isEmpty) {
      return null;
    }
    var paramObj = {"method": "system_properties", "params": [], "id": 1, "jsonrpc": "2.0"};
    try {
      resultMap = await request(netUrl, formData: paramObj);
      return resultMap;
    } catch (e) {
      Logger().e("loadSystemProperties error is  ", e.toString());
      return null;
    }
  }

  Future<Map> updateSubChainBasicInfo(String infoId) async {
    Map runtimeMap = await loadScryXRuntimeVersion();
    if (runtimeMap == null || !runtimeMap.containsKey("result")) {
      return null;
    }
    var runtimeResultMap = runtimeMap["result"];
    if (runtimeResultMap == null || !runtimeResultMap.containsKey("specVersion") || !runtimeResultMap.containsKey("transactionVersion")) {
      return null;
    }
    int runtimeVersion = runtimeResultMap["specVersion"];
    int txVersion = runtimeResultMap["transactionVersion"];

    Map blockHashMap = await loadScryXBlockHash();
    if (blockHashMap == null || !blockHashMap.containsKey("result")) {
      return null;
    }
    String genesisHash = blockHashMap["result"];

    Map metaDataMap = await loadMetadata();
    if (metaDataMap == null || !metaDataMap.containsKey("result")) {
      return null;
    }
    String metadata = metaDataMap["result"];

    Map systemPropertiesMap = await loadSystemProperties();
    if (systemPropertiesMap == null || !systemPropertiesMap.containsKey("result")) {
      return null;
    }
    Map resultMap = Map();
    Map propertiesResultMap = systemPropertiesMap["result"];
    int ss58Format = propertiesResultMap["ss58Format"];
    int tokenDecimals = propertiesResultMap["tokenDecimals"];
    String tokenSymbol = propertiesResultMap["tokenSymbol"];
    if (runtimeVersion != null &&
        txVersion != null &&
        genesisHash != null &&
        metadata != null &&
        ss58Format != null &&
        tokenDecimals != null &&
        tokenSymbol != null) {
      Map updateMap = await Wallets.instance
          .updateSubChainBasicInfo(infoId, runtimeVersion, txVersion, genesisHash, metadata, ss58Format, tokenDecimals, tokenSymbol);
      return updateMap;
    }

    return resultMap;
  }
}
