import 'package:chatai/models/response.dart';
import 'package:chatai/utils/common_functions.dart';
import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rate_my_app/rate_my_app.dart';

VersionWiseResponse staticVersionWiseResponse;
AdsDataResponse staticAdsDataResponse;
PackageInfo packageInfo;
int onInterClickAdCounter = 3;
int onNativeCounter = 3;
int onBannerCounter = 3;
DateTime proLimitDate;

bool isSubscriptionActive = false;

class SharedPrefKeys {
  static String isVoiceOn = 'isVoiceOn';
  static String isWelcomeScreenDone = 'isWelcomeScreenDone';
  static String token = 'token';
}

Widget isBannerVisible() {
  if (staticVersionWiseResponse.showAds/* && !isSubscriptionActive*/) {
    if (onBannerCounter >= staticVersionWiseResponse.bannerAdCounter) {
      onBannerCounter = 0;
      return ConstrainedBox(
          constraints: BoxConstraints(minWidth: CommonMethods.screenWidth),
          child: EasySmartBannerAd(
            priorityAdNetworks: staticVersionWiseResponse.onlyFacebookAdShow == true
                ? [AdNetwork.facebook, AdNetwork.admob]
                : [AdNetwork.admob, AdNetwork.facebook],
            adSize: AdSize.banner,
          ));
    } else {
      onBannerCounter++;
      return Container();
    }
  } else {
    return Container();
  }
}

Function showRatingBar(BuildContext context) {
  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 1,
    googlePlayIdentifier: packageInfo.packageName,
    appStoreIdentifier: '1670682415',
  );

  rateMyApp.init().then((_) {
    rateMyApp.showRateDialog(
      context,
      ignoreNativeDialog: false,
      dialogStyle: const DialogStyle(),
      onDismissed: () =>
          rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
    );
  });
}
