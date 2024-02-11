import 'dart:io';

import 'package:chatai/utils/constant.dart';
import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

InterstitialAd interstitialAd;

class InterstitialAdController {
  static Function loadInterstitialAd() {
    final AdRequest request = AdRequest();
    InterstitialAd.load(
        adUnitId: staticAdsDataResponse.gInt,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded ffffffffff');
            interstitialAd = ad;
            interstitialAd.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            interstitialAd = null;
            loadInterstitialAd();
          },
        ));
  }

  static Function showInterstitialAd(Function callback) {
    if (staticVersionWiseResponse.onlyFacebookAdShow) {
      EasyAds.instance
          .showAd(AdUnitType.interstitial, adNetwork: AdNetwork.facebook);
      callback();
    }else {
      if (interstitialAd != null) {
        interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (InterstitialAd ad) =>
              print('ad onAdShowedFullScreenContent.'),
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            print('$ad onAdDismissedFullScreenContent.');
            loadInterstitialAd();
            callback();
            ad.dispose();
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
            print('$ad onAdFailedToShowFullScreenContent: $error');
            ad.dispose();
            loadInterstitialAd();
          },
        );
        interstitialAd.show();
      }
    }
  }

  static Function clickCountdownAds(Function callback) {
    if (staticVersionWiseResponse.showAds) {
      if (onInterClickAdCounter >=
          staticVersionWiseResponse.interstitialAdCounter) {
        onInterClickAdCounter = 0;
        print('ad onAdShowedFullScreenContent. 11111');
        showInterstitialAd(() {
          print('ad onAdShowedFullScreenContent. 22222');
          callback();
        });
      } else {
        print('ad onAdShowedFullScreenContent. 33333');
        onInterClickAdCounter++;
        callback();
      }
    } else {
      print('ad onAdShowedFullScreenContent. 44444');
      callback();
    }
  }
}
