import 'dart:core';

class APIHelper {
  static NetworkEnvironment networkEnvironment = NetworkEnvironment.staticJson;
}

enum NetworkEnvironment { staticJson, chatGptApi }

//api name
enum EndPointItem {
  staticJson,
  chatGptApi
}

enum Bool { False, True }

extension FullURL on EndPointItem {
  String get baseURL {
    switch (this) {
      case EndPointItem.staticJson:
        return "https://jbinfosoft.com/FLT/";
      case EndPointItem.chatGptApi:
        return "https://api.openai.com/";
    }
  }

  String get url {
    switch (this) {
      default:
        return baseURL + path;
    }
  }

  String get path {
    switch (this) {
      case EndPointItem.staticJson:
        return 'ad_gpt_flutter.json';
      case EndPointItem.chatGptApi:
        return 'v1/completions';
    }
  }
}