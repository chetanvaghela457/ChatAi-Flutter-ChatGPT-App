import 'package:chatai/screens/chat_screen.dart';
import 'package:chatai/screens/no_connection.dart';
import 'package:chatai/utils/animate_transition.dart';
import 'package:chatai/utils/app_colors.dart';
import 'package:chatai/utils/common_functions.dart';
import 'package:chatai/utils/connectivity_service.dart';
import 'package:chatai/utils/constant.dart';
import 'package:chatai/utils/interstitial_ads.dart';
import 'package:chatai/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LetsChatScreen extends StatefulWidget {
  const LetsChatScreen({Key key}) : super(key: key);

  @override
  State<LetsChatScreen> createState() => _LetsChatScreenState();
}

class _LetsChatScreenState extends State<LetsChatScreen> {
  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);
    CommonMethods.configure(context);
    return connectionStatus == ConnectivityStatus.Offline
        ? NoConnectionScreen()
        : _body();
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: TextStyle(
          fontSize: 16,
          color: AppColors.colorWhite,
          fontWeight: FontWeight.bold));

  Widget _body() {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                    child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'AI CHAT',
                        style: TextStyle(
                            color: AppColors.colorPrimary,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: CommonMethods.screenHeight * 0.02,
                      ),
                      Image(
                        image: AssetImage(
                            Strings.prefix_img_path + "lest_start_img.jpg"),
                        width: CommonMethods.screenWidth * 0.7,
                        height: CommonMethods.screenWidth * 0.7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 15),
                        child: Center(
                          child: Text(
                              "Using this Application, you can ask questions and receive articles using the Artificial Intelligence",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.colorBlack,
                                fontSize: CommonMethods.screenWidth*0.05,
                                fontWeight: FontWeight.bold
                              )),
                        ),
                      ),
                      Container(
                        width: CommonMethods.screenWidth * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(Strings.true_icon),
                              width: 20,
                              height: 20,
                              color: AppColors.colorBlack,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: Text(
                                    "Unlimited usage - unlimited questions and answers",
                                    style: TextStyle(
                                      color: AppColors.colorBlack,
                                      fontSize: 17.0,
                                    ))),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: CommonMethods.screenWidth * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage(Strings.true_icon),
                              width: 20,
                              height: 20,
                              color: AppColors.colorBlack,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: Text("Ads Free Experience",
                                    style: TextStyle(
                                      color: AppColors.colorBlack,
                                      fontSize: 17.0,
                                    ))),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: CommonMethods.screenWidth * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image(
                              image: AssetImage(Strings.true_icon),
                              width: 20,
                              height: 20,
                              color: AppColors.colorBlack,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: Text("More Efficient Response",
                                    style: TextStyle(
                                      color: AppColors.colorBlack,
                                      fontSize: 17.0,
                                    ))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: CommonMethods.screenHeight * 0.03,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            minWidth: CommonMethods.screenWidth * 0.7,
                            minHeight: CommonMethods.screenHeight * 0.07),
                        child: ElevatedButton(
                          style: style,
                          onPressed: () {
                            InterstitialAdController.clickCountdownAds(() {
                              Navigator.of(context).push(
                                  AnimationPage.createFadeRoute(
                                      ChatScreen(chatMessage: "")));
                            });
                          },
                          child: const Text(
                            'User, Let\'s Chat',
                            style: TextStyle(fontSize: 20, letterSpacing: 2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: CommonMethods.screenHeight * 0.02,
                      ),
                    ],
                  ),
                )),
              ),
            ),
            isBannerVisible()
          ],
        ),
      ),
    );
  }
}
