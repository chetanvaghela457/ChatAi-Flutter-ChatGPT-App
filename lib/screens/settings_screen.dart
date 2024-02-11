import 'dart:io';

import 'package:chatai/screens/nav_drawer.dart';
import 'package:chatai/screens/no_connection.dart';
import 'package:chatai/utils/animate_transition.dart';
import 'package:chatai/utils/app_colors.dart';
import 'package:chatai/utils/common_functions.dart';
import 'package:chatai/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/connectivity_service.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    CommonMethods.configure(context);

    return connectionStatus == ConnectivityStatus.Offline
        ? NoConnectionScreen()
        : SafeArea(
            top: false,
            bottom: false,
            left: false,
            right: false,
            child: Scaffold(
                body: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: CommonMethods.screenHeight * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Settings',
                          style: TextStyle(
                              color: AppColors.colorPrimary,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context)
                      //     .push(AnimationPage.createFadeRoute(PremiumScreen()));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.colorBlack,
                            borderRadius: BorderRadius.circular(20)),
                        width: CommonMethods.screenWidth * 0.9,
                        height: CommonMethods.screenHeight * 0.18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: CommonMethods.screenWidth * 0.61,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: CommonMethods.screenWidth * 0.04),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Upgrade to Premium+",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Flexible(
                                        child: Text(
                                            "Unlimited usage, Unlimited\nquestions and answers,\nAds Free Experience",
                                            style: TextStyle(
                                              color: AppColors.colorLightGrey,
                                              fontSize: 14.0,
                                            ))),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: CommonMethods.screenWidth * 0.25,
                              margin: EdgeInsets.only(
                                  right: CommonMethods.screenWidth * 0.04),
                              decoration: BoxDecoration(
                                  color: AppColors.colorPrimary,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 8, bottom: 8),
                                child: Text(
                                  "Upgrade",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.colorWhite),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.colorWhite,
                          borderRadius: BorderRadius.circular(20)),
                      width: CommonMethods.screenWidth * 0.9,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showRatingBar(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 20, right: 10, bottom: 20),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.star_outlined,
                                      color: AppColors.colorBlack),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Leave a review',
                                      style: TextStyle(
                                          color: AppColors.colorBlack,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Icon(Icons.chevron_right,
                                      color: AppColors.colorBlack),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: AppColors.colorLightGrey,
                          ),
                          GestureDetector(
                            onTap: () {
                              send();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 20, right: 10, bottom: 20),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.email_rounded,
                                      color: AppColors.colorBlack),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Contact support',
                                      style: TextStyle(
                                          color: AppColors.colorBlack,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Icon(Icons.chevron_right,
                                      color: AppColors.colorBlack),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: AppColors.colorLightGrey,
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchInBrowser(Uri.parse(staticVersionWiseResponse.moreAppsUrl));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 20, right: 10, bottom: 20),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.screen_share_rounded,
                                      color: AppColors.colorBlack),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Terms of use',
                                      style: TextStyle(
                                          color: AppColors.colorBlack,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Icon(Icons.chevron_right,
                                      color: AppColors.colorBlack),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: AppColors.colorLightGrey,
                          ),
                          GestureDetector(
                            onTap: () {
                              _launchInBrowser(Uri.parse(
                                  staticVersionWiseResponse.privacyPolicyUrl));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, top: 20, right: 10, bottom: 20),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.privacy_tip,
                                      color: AppColors.colorBlack),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Privacy Policy',
                                      style: TextStyle(
                                          color: AppColors.colorBlack,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Icon(Icons.chevron_right,
                                      color: AppColors.colorBlack),
                                ],
                              ),
                            ),
                          ),
                          // Divider(
                          //   height: 0.5,
                          //   thickness: 0.5,
                          //   color: AppColors.colorLightGrey,
                          // ),
                          // GestureDetector(
                          //   onTap: () {
                          //     restorePurchase();
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(
                          //         left: 10, top: 20, right: 10, bottom: 20),
                          //     child: Row(
                          //       children: [
                          //         const SizedBox(
                          //           width: 5,
                          //         ),
                          //         Icon(CupertinoIcons.table_badge_more_fill,
                          //             color: AppColors.colorBlack),
                          //         const SizedBox(
                          //           width: 15,
                          //         ),
                          //         Expanded(
                          //           child: Text(
                          //             'Restore Subscription',
                          //             style: TextStyle(
                          //                 color: AppColors.colorBlack,
                          //                 fontSize: 20.0,
                          //                 fontWeight: FontWeight.bold),
                          //           ),
                          //         ),
                          //         Icon(Icons.chevron_right,
                          //             color: AppColors.colorBlack),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  isBannerVisible()
                ],
              ),
            )));
  }

  Future<void> send() async {
    final Email email = Email(
      body: "Type your suggestion or problem details here.",
      subject: packageInfo.appName,
      recipients: [staticVersionWiseResponse.emailAddress],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  // Future<void> restorePurchase() async {
  //   try {
  //     CustomerInfo restoredInfo = await Purchases.restorePurchases();
  //
  //     if (restoredInfo.entitlements.all["AiChatPro"].isActive) {
  //       isSubscriptionActive = true;
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text("Purchase Restored"),
  //       ));
  //       Navigator.of(context).push(AnimationPage.createFadeRoute(NavDrawer()));
  //     } else {
  //       isSubscriptionActive = false;
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text("No Purchase Found"),
  //       ));
  //     }
  //   } on PlatformException catch (e) {
  //     print(e.message);
  //   }
  // }

  Future<void> share(String text) async {
    await FlutterShare.share(
        title: text, text: text, chooserTitle: 'Share App');
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
