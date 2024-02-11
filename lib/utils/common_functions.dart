import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'app_colors.dart';
import 'strings.dart';

class CommonMethods {
  static BuildContext context = null;

  static Function configure(BuildContext contexts) {
    context = contexts;
  }

  static double get screenHeight {
    return MediaQuery.of(context).size.height;
  }

  static double get screenWidth {
    return MediaQuery.of(context).size.width;
  }

  static SizedBox sizedBox({double width,double height}) {
    return SizedBox(
      width: width,
      height: height,
    );
  }

  static AppBar appBar(
      {String title,
      double fontSize}) {
    return AppBar(
          backgroundColor: AppColors.colorPrimary,
          elevation: 4,
          title: Text(
            title,
            style: textStyle(fontSize),
          ),
          centerTitle: true);
  }

  static TextStyle textStyle(double fontSize) {
    return TextStyle(
        color: AppColors.colorWhite,
        fontSize: fontSize,
        fontWeight: FontWeight.bold);
  }

  static final spinkit = SpinKitRing(
    color: AppColors.colorPrimary,
    lineWidth: 3,
    size: 35,
  );

  static double reciprocal(dynamic d) => d / 1.0;
}

// Global Exception For Api Response
class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
