import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'config.dart';

class HandleConfig {
  factory HandleConfig() => _getInstance();

  static HandleConfig get instance => _getInstance();
  static HandleConfig _instance;
  static String configDocumentPath = "/scry";
  static String configFileName = "config.json";
  static String defaultConfigFilePath = "assets/config/config.json";

  HandleConfig._internal() {
    //
  }

  static HandleConfig _getInstance() {
    if (_instance == null) {
      _instance = new HandleConfig._internal();
    }
    return _instance;
  }

  Future<Config> getConfig() async {
    File file = await _getConfigFile(configFileName);
    String fileContent = await file.readAsString();
    Map configMap = jsonDecode(fileContent);
    Config config = Config.fromJson(configMap);
    return config;
  }

  Future<bool> saveConfig(final Config config) async {
    if (config == null) {
      return false;
    }
    try {
      File file = await _getConfigFile(configFileName);
      String fileString = jsonEncode(config.toJson());
      file.writeAsString(fileString, flush: true);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<bool> addOrUpdateVendorConfig(final String jsonString) async {
    if (jsonString == null) {
      return false;
    }
    try {
      Config config = await this.getConfig();
      var applyMap = config.vendorConfig.toJson();
      VendorConfig.fromJson(json.decode(jsonString)).toJson().forEach((key, value) {
        if (key.isNotEmpty && value != null && value != "") {
          applyMap[key] = value;
        }
      });
      config.vendorConfig = VendorConfig.fromJson(applyMap);
      this.saveConfig(config);
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<File> _getConfigFile(String fileName) async {
    String docPath = await _getDirectoryPath();
    final filePath = docPath + "/" + fileName;
    File file = File(filePath);
    if (!await file.exists()) {
      String jsonStr = await rootBundle.loadString(defaultConfigFilePath);
      file.writeAsString(jsonStr, flush: true);
    }
    return file;
  }

  Future<String> _getDirectoryPath() async {
    final filepath = await getApplicationDocumentsDirectory();
    var file = Directory(filepath.path + configDocumentPath);
    try {
      bool exists = await file.exists();
      if (!exists) {
        await file.create();
      }
    } catch (e) {
      print(e);
    }
    return file.path;
  }
}
