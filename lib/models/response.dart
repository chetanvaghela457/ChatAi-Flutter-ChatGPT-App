import 'dart:ffi';
import 'dart:io';

import 'package:chatai/utils/api_helper.dart';
import 'package:chatai/utils/constant.dart';
import 'package:flutter/cupertino.dart';

class Response {
  VersionWiseResponse versionWiseResponse;
  AdsDataResponse adsDataResponse;
  List<ChoiceItem> choices;

  Response(
      {this.versionWiseResponse,
      this.adsDataResponse,
      this.choices});

  static Response fromJson(Map<String, dynamic> json, EndPointItem item) {
    switch (item) {
      case EndPointItem.staticJson:
        return Response(
            adsDataResponse: AdsDataResponse.fromJson(json["adsData"]),
            versionWiseResponse: VersionWiseResponse.fromJson(
                json["version"]),
            );
        break;
      case EndPointItem.chatGptApi:
        List data = json["choices"];
        return Response(
            choices:
                data.map((choice) => ChoiceItem.fromJson(choice)).toList());
        break;
    }
  }

  Map<String, dynamic> toJson() => {
        "adsDataResponse": adsDataResponse,
        "versionWiseResponse": versionWiseResponse,
        "choices": choices
      };
}

class AdsDataResponse {
  AdsDataResponse({
    this.fbAppId,
    this.fBan,
    this.fNat,
    this.fInter,
    this.gAppId,
    this.gInt,
    this.gNat,
    this.gBan,
    this.gAOpen,
  });

  String fbAppId;
  String fBan;
  String fNat;
  String fInter;
  String gAppId;
  String gInt;
  String gNat;
  String gBan;
  String gAOpen;

  factory AdsDataResponse.fromJson(Map<String, dynamic> json) =>
      AdsDataResponse(
        fbAppId: json["fbAppId"] == null ? null : json["fbAppId"],
        fBan: json["fBan"] == null ? null : json["fBan"],
        fNat: json["fNat"] == null ? null : json["fNat"],
        fInter: json["fInter"] == null ? null : json["fInter"],
        gAppId: json["gAppId"] == null ? null : json["gAppId"],
        gInt: json["gInt"] == null ? null : json["gInt"],
        gNat: json["gNat"] == null ? null : json["gNat"],
        gBan: json["gBan"] == null ? null : json["gBan"],
        gAOpen: json["gAOpen"] == null ? null : json["gAOpen"],
      );

  Map<String, dynamic> toJson() => {
        "fbAppId": fbAppId,
        "fBan": fBan,
        "fNat": fNat,
        "fInter": fInter,
        "gAppId": gAppId,
        "gInt": gInt,
        "gNat": gNat,
        "gBan": gBan,
        "gAOpen": gAOpen,
      };
}

// class NotificationDataResponse {
//   NotificationDataResponse(
//       {this.title, this.desc, this.timeHour, this.timeMinute});
//
//   String title;
//   String desc;
//   int timeHour;
//   int timeMinute;
//
//   factory NotificationDataResponse.fromJson(Map<String, dynamic> json) =>
//       NotificationDataResponse(
//         title: json["title"] == null ? null : json["title"],
//         desc: json["desc"] == null ? null : json["desc"],
//         timeHour: json["timeHour"] == null ? null : json["timeHour"],
//         timeMinute: json["timeMinute"] == null ? null : json["timeMinute"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "desc": desc,
//         "timeHour": timeHour,
//         "timeMinute": timeMinute,
//       };
// }

class VersionWiseResponse {
  VersionWiseResponse(
      {this.showAds,
      this.mainApiToken,
      this.tokenWiseDataFilter,
      this.frequency,
      this.model,
      this.max_tokens,
      this.interstitialAdCounter,
      this.nativeAdCounter,
      this.bannerAdCounter,
      this.onlyFacebookAdShow,
      this.newPlayStoreAppUrl,
      this.privacyPolicyUrl,
      this.moreAppsUrl,this.emailAddress});

  bool showAds;
  String mainApiToken;
  bool tokenWiseDataFilter;
  double frequency;
  String model;
  int max_tokens;
  int interstitialAdCounter;
  int nativeAdCounter;
  int bannerAdCounter;
  bool onlyFacebookAdShow;
  String newPlayStoreAppUrl;
  String privacyPolicyUrl;
  String moreAppsUrl;
  String emailAddress;

  factory VersionWiseResponse.fromJson(Map<String, dynamic> json) =>
      VersionWiseResponse(
        showAds: json["showAds"] == null ? null : json["showAds"],
        mainApiToken:
            json["mainApiToken"] == null ? null : json["mainApiToken"],
        tokenWiseDataFilter: json["tokenWiseDataFilter"] == null
            ? null
            : json["tokenWiseDataFilter"],
        frequency: json["frequency"] == null ? null : json["frequency"],
        model: json["model"] == null ? null : json["model"],
        max_tokens: json["max_tokens"] == null ? null : json["max_tokens"],
        interstitialAdCounter: json["interstitialAdCounter"] == null
            ? null
            : json["interstitialAdCounter"],
        nativeAdCounter:
            json["nativeAdCounter"] == null ? null : json["nativeAdCounter"],
        bannerAdCounter:
            json["bannerAdCounter"] == null ? null : json["bannerAdCounter"],
        onlyFacebookAdShow: json["onlyFacebookAdShow"] == null
            ? null
            : json["onlyFacebookAdShow"],
        newPlayStoreAppUrl: json["newPlayStoreAppUrl"] == null
            ? null
            : json["newPlayStoreAppUrl"],
        privacyPolicyUrl:
            json["privacyPolicyUrl"] == null ? null : json["privacyPolicyUrl"],
        moreAppsUrl: json["moreAppsUrl"] == null ? null : json["moreAppsUrl"],
        emailAddress: json["emailAddress"] == null ? null : json["emailAddress"],
      );

  Map<String, dynamic> toJson() => {
        "showAds": showAds,
        "mainApiToken": mainApiToken,
        "tokenWiseDataFilter": tokenWiseDataFilter,
        "frequency": frequency,
        "model": model,
        "max_tokens": max_tokens,
        "interstitialAdCounter": interstitialAdCounter,
        "nativeAdCounter": nativeAdCounter,
        "bannerAdCounter": bannerAdCounter,
        "onlyFacebookAdShow": onlyFacebookAdShow,
        "newPlayStoreAppUrl": newPlayStoreAppUrl,
        "privacyPolicyUrl": privacyPolicyUrl,
        "moreAppsUrl": moreAppsUrl,
        "emailAddress": emailAddress,
      };
}

class GPTResultResponse {
  GPTResultResponse({this.id, this.choices});

  String id;
  List<ChoiceItem> choices;

  factory GPTResultResponse.fromJson(Map<String, dynamic> json) =>
      GPTResultResponse(
        id: json["id"] == null ? null : json["id"],
        choices: List<ChoiceItem>.from(
            json["choices"].map((x) => ChoiceItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
      };
}

class ChoiceItem {
  ChoiceItem({this.text, this.index, this.finish_reason});

  String text;
  String finish_reason;
  int index;

  factory ChoiceItem.fromJson(Map<String, dynamic> json) => ChoiceItem(
      text: json["text"] == null ? null : json["text"],
      index: json["index"] == null ? null : json["index"],
      finish_reason:
          json["finish_reason"] == null ? null : json["finish_reason"]);

  Map<String, dynamic> toJson() =>
      {"text": text, "index": index, "finish_reason": finish_reason};
}
