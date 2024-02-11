import 'dart:convert';

import 'package:chatai/screens/no_connection.dart';
import 'package:chatai/screens/question_screen.dart';
import 'package:chatai/utils/animate_transition.dart';
import 'package:chatai/utils/app_colors.dart';
import 'package:chatai/utils/common_functions.dart';
import 'package:chatai/utils/connectivity_service.dart';
import 'package:chatai/utils/constant.dart';
import 'package:chatai/utils/interstitial_ads.dart';
import 'package:chatai/utils/strings.dart';
import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List categories = [];

  Future loadData() async {
    var data = await rootBundle.loadString(Strings.category_data_json);
    setState(() {
      categories = json.decode(data);
    });
  }

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
    loadData();
    super.initState();
  }

  Widget _body() {
    AppBar appBar =
        CommonMethods.appBar(title: Strings.categories, fontSize: 20);
    return SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        body: Container(
            width: CommonMethods.screenWidth,
            height: CommonMethods.screenHeight,
            child: Column(
              children: [
                SizedBox(
                  height: CommonMethods.screenHeight * 0.05,
                ),
                Text(
                  'Categories',
                  style: TextStyle(
                      color: AppColors.colorPrimary,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                    child: GridView.builder(
                        padding: Vx.m8,
                        itemCount: categories.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              InterstitialAdController.clickCountdownAds(() {
                                List<String> categoriesList = List<String>.from(
                                    categories[index]["items"] as List);
                                Navigator.of(context).push(
                                    AnimationPage.createFadeRoute(
                                        QuestionsScreen(
                                            categoriesList,
                                            categories[index]
                                                ["categoryName"])));
                              });
                            },
                            child: Card(
                              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              elevation: 3,
                              child: Column(
                                children: [
                                  Image(
                                    image: AssetImage(Strings.prefix_img_path +
                                        categories[index]["categoryImage"] +
                                        ".jpg"),
                                    width: MediaQuery.of(context).size.width * 0.23,
                                    height: MediaQuery.of(context).size.width * 0.23,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  Center(
                                      child: Text(
                                    categories[index]["categoryName"],
                                    style: TextStyle(
                                        color: AppColors.colorBlack,
                                        fontWeight: FontWeight.normal,
                                        fontSize: MediaQuery.of(context).size.width * 0.04),
                                  ))
                                ],
                              ),
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
