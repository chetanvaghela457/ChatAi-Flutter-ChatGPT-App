import 'package:chatai/screens/chat_screen.dart';
import 'package:chatai/screens/no_connection.dart';
import 'package:chatai/utils/animate_transition.dart';
import 'package:chatai/utils/app_colors.dart';
import 'package:chatai/utils/common_functions.dart';
import 'package:chatai/utils/connectivity_service.dart';
import 'package:chatai/utils/constant.dart';
import 'package:chatai/utils/interstitial_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class QuestionsScreen extends StatefulWidget {
  List<String> questions;
  String categoryName;

  QuestionsScreen(this.questions, this.categoryName);

  @override
  _QuestionsScreenState createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
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

  Widget _body() {
    AppBar appBar = CommonMethods.appBar(
        title: widget.categoryName, fontSize: 20);
    return SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        appBar: appBar,
        body: Container(
            width: CommonMethods.screenWidth,
            height: CommonMethods.screenHeight,
            child: Column(
              children: [
                Flexible(
                    child: ListView.builder(
                        padding: Vx.m8,
                        itemCount: widget.questions.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              InterstitialAdController.clickCountdownAds((){
                                Navigator.of(context).push(
                                    AnimationPage.createFadeRoute(ChatScreen(
                                        chatMessage: widget.questions[index])));
                              });
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                          child: Text(
                                        widget.questions[index],
                                        style: TextStyle(
                                            color: AppColors.colorBlack,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ))
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 0.5,
                                  thickness: 0.5,
                                  color: AppColors.colorLightGrey,
                                ),
                              ],
                            ),
                          );
                        })),
                isBannerVisible()
              ],
            )),
      ),
    );
  }
}
