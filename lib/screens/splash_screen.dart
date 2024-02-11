import 'dart:math';

import 'package:chatai/models/response.dart';
import 'package:chatai/presenter/presenter.dart';
import 'package:chatai/screens/nav_drawer.dart';
import 'package:chatai/screens/welcome_screen.dart';
import 'package:chatai/utils/ad_id_manager.dart';
import 'package:chatai/utils/api_helper.dart';
import 'package:chatai/utils/app_colors.dart';
import 'package:chatai/utils/constant.dart';
import 'package:chatai/utils/interface.dart';
import 'package:chatai/utils/interstitial_ads.dart';
import 'package:chatai/utils/shared_pref_helper.dart';
import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../utils/animate_transition.dart';
import '../utils/common_functions.dart';
import '../utils/strings.dart';
import 'package:timezone/timezone.dart' as tz;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

const IAdIdManager adIdManager = AdIdManager();

class _SplashScreenState extends State<SplashScreen>
    implements Contract, ApiResult {
  double screenWidth = 0.0;
  double screenHeight = 0.0;
  Presenter _presenter;
  bool isLoading = false;
  SharedPreferences shared;

  _SplashScreenState() {
    _presenter = new Presenter(this);
  }

  @override
  void initState() {
    super.initState();
    // getData();
    getPackage();
    isLoading = true;
    _presenter.getRequest(EndPointItem.staticJson);
  }

  void getPackage() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  // Future<void> getData() async {
  //   try {
  //     CustomerInfo customerInfo = await Purchases.getCustomerInfo();
  //     if (customerInfo.entitlements.all["AiChatPro"].isActive) {
  //       isSubscriptionActive = true;
  //     } else {
  //       isSubscriptionActive = false;
  //     }
  //   } on PlatformException catch (e) {
  //     print(e.message);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    CommonMethods.configure(context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Center(
      child: Container(
        color: AppColors.colorPrimary,
        width: screenWidth,
        height: screenHeight,
        child: _mobileView(),
      ),
    ));
  }

  Widget _mobileView() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: CommonMethods.screenWidth,
              height: CommonMethods.screenWidth,
              child: Image.asset(Strings.img_bot,
                  width: screenWidth, height: screenWidth)),
        ],
      ),
    );
  }

  @override
  void onFailed(String message, EndPointItem request) {
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onSuccess(Response response, EndPointItem request) {
    setState(() async {
      isLoading = false;
      staticAdsDataResponse = response.adsDataResponse;
      staticVersionWiseResponse = response.versionWiseResponse;

      if (staticVersionWiseResponse.showAds/* && !isSubscriptionActive*/) {
        await EasyAds.instance.initialize(adIdManager,
            adMobAdRequest: const AdRequest(),
            fbTestMode: false,
            fbiOSAdvertiserTrackingEnabled: false,
            enableLogger: false);

        if (staticVersionWiseResponse.onlyFacebookAdShow) {
          EasyAds.instance.loadAd();
        } else {
          InterstitialAdController.loadInterstitialAd();
        }
      }

      Future.delayed(Duration(seconds: 4), () async {
        shared = await SharedPreferences.getInstance();

        bool isWelcomeScreenDone = SharedPreferencesHelper.getBoolean(
            SharedPrefKeys.isWelcomeScreenDone, shared);
        if (isWelcomeScreenDone) {
          // if (isSubscriptionActive) {
          InterstitialAdController.clickCountdownAds(() {
            Navigator.of(context)
                .pushReplacement(AnimationPage.createFadeRoute(NavDrawer()));
          });
          // } else {
          //   InterstitialAdController.clickCountdownAds(() {
          //     Navigator.of(context).pushReplacement(
          //         AnimationPage.createFadeRoute(PremiumScreen()));
          //   });
          // }
        } else {
          InterstitialAdController.clickCountdownAds(() {
            Navigator.of(context).pushReplacement(
                AnimationPage.createFadeRoute(WelcomeScreen()));
          });
        }
      });
    });
  }

  @override
  void onSuccessResponse() {}
}
