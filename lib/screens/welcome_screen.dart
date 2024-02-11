import 'package:chatai/screens/nav_drawer.dart';
import 'package:chatai/screens/no_connection.dart';
import 'package:chatai/utils/app_colors.dart';
import 'package:chatai/utils/common_functions.dart';
import 'package:chatai/utils/connectivity_service.dart';
import 'package:chatai/utils/constant.dart';
import 'package:chatai/utils/interstitial_ads.dart';
import 'package:chatai/utils/shared_pref_helper.dart';
import 'package:chatai/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreen createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    CommonMethods.configure(context);

    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return connectionStatus == ConnectivityStatus.Offline
        ? NoConnectionScreen()
        : IntroductionScreen(
            key: introKey,
            globalBackgroundColor: Colors.white,
            allowImplicitScrolling: true,
            autoScrollDuration: 3000,
            pages: [
              PageViewModel(
                titleWidget: Text(Strings.welcome_1_title,
                    style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorPrimary),
                    textAlign: TextAlign.center),
                bodyWidget: Center(
                  child: Text(Strings.welcome_1_description,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: AppColors.colorGrey),
                      textAlign: TextAlign.center),
                ),
                image: _buildImage(Strings.img_welcome_1),
                reverse: true,
                decoration: pageDecoration.copyWith(
                    bodyFlex: 3,
                    imageFlex: 4,
                    bodyAlignment: Alignment.bottomCenter,
                    imageAlignment: Alignment.topCenter),
              ),
              PageViewModel(
                titleWidget: Text(Strings.welcome_2_title,
                    style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorPrimary),
                    textAlign: TextAlign.center),
                bodyWidget: Center(
                  child: Text(Strings.welcome_2_description,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: AppColors.colorGrey),
                      textAlign: TextAlign.center),
                ),
                image: _buildImage(Strings.img_welcome_2),
                reverse: true,
                decoration: pageDecoration.copyWith(
                    bodyFlex: 3,
                    imageFlex: 4,
                    bodyAlignment: Alignment.bottomCenter,
                    imageAlignment: Alignment.topCenter),
              ),
              PageViewModel(
                titleWidget: Text(Strings.welcome_3_title,
                    style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorPrimary),
                    textAlign: TextAlign.center),
                bodyWidget: Center(
                  child: Text(Strings.welcome_3_description,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: AppColors.colorGrey),
                      textAlign: TextAlign.center),
                ),
                image: _buildImage(Strings.img_welcome_3),
                reverse: true,
                decoration: pageDecoration.copyWith(
                    bodyFlex: 3,
                    imageFlex: 4,
                    bodyAlignment: Alignment.bottomCenter,
                    imageAlignment: Alignment.topCenter),
              ),
              PageViewModel(
                titleWidget: Text(Strings.welcome_4_title,
                    style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorPrimary),
                    textAlign: TextAlign.center),
                bodyWidget: Center(
                  child: Text(Strings.welcome_4_description,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: AppColors.colorGrey),
                      textAlign: TextAlign.center),
                ),
                image: _buildImage(Strings.img_welcome_4),
                reverse: true,
                decoration: pageDecoration.copyWith(
                    bodyFlex: 3,
                    imageFlex: 4,
                    bodyAlignment: Alignment.bottomCenter,
                    imageAlignment: Alignment.topCenter),
              ),
              PageViewModel(
                titleWidget: Text(Strings.welcome_5_title,
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorPrimary),
                    textAlign: TextAlign.center),
                bodyWidget: Center(
                  child: Text(Strings.welcome_5_description,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: AppColors.colorGrey),
                      textAlign: TextAlign.center),
                ),
                decoration: pageDecoration.copyWith(
                  bodyFlex: 3,
                  imageFlex: 4,
                  bodyAlignment: Alignment.bottomCenter,
                  imageAlignment: Alignment.topCenter,
                ),
                image: _buildImage(Strings.img_welcome_5),
                reverse: true,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
            showSkipButton: false,
            skipOrBackFlex: 0,
            nextFlex: 0,
            showBackButton: true,
            //rtl: true, // Display as right-to-left
            back: const Icon(Icons.arrow_back),
            skip: const Text('Skip',
                style: TextStyle(fontWeight: FontWeight.w600)),
            next: const Icon(Icons.arrow_forward),
            done: const Text('Done',
                style: TextStyle(fontWeight: FontWeight.w600)),
            curve: Curves.fastLinearToSlowEaseIn,
            controlsMargin: const EdgeInsets.all(16),
            controlsPadding: const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ));
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    InterstitialAdController.clickCountdownAds(() async {
      SharedPreferences shared = await SharedPreferences.getInstance();

      SharedPreferencesHelper.saveBoolean(
          SharedPrefKeys.isWelcomeScreenDone, true, shared);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => NavDrawer()),
      );
    });
  }

  Widget _buildImage(String assetName,
      [double width = 350, double height = 350]) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
    );
  }
}
