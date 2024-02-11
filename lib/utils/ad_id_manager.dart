import 'dart:io';

import 'package:chatai/utils/constant.dart';
import 'package:easy_ads_flutter/easy_ads_flutter.dart';

class AdIdManager extends IAdIdManager {
  const AdIdManager();

  @override
  AppAdIds get admobAdIds => AppAdIds(
        appId: staticAdsDataResponse.gAppId,
        appOpenId: staticAdsDataResponse.gAOpen,
        bannerId: staticAdsDataResponse.gBan,
        interstitialId: staticAdsDataResponse.gInt,
      );

  @override
  AppAdIds get unityAdIds => AppAdIds();

  @override
  AppAdIds get appLovinAdIds => AppAdIds();

  @override
  AppAdIds get fbAdIds => AppAdIds(
        appId: staticAdsDataResponse.fbAppId,
        interstitialId: staticAdsDataResponse.fInter,
        bannerId: staticAdsDataResponse.fBan
      );
}
