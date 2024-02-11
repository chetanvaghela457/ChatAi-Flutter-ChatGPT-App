import 'package:chatai/utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoConnectionScreen extends StatefulWidget {
  @override
  _NoConnectionScreenState createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    CommonMethods.configure(context);
    return Scaffold(
        body: Center(
      child: Container(
        width: CommonMethods.screenWidth * 0.5,
        height: CommonMethods.screenWidth * 0.5 / 0.7272727272,
        child: Lottie.asset('assets/images/no_internet.json'),
      ),
    ));
  }
}
