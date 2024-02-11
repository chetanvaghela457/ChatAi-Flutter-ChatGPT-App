import 'package:chatai/utils/app_colors.dart';
import 'package:chatai/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'common_functions.dart';
import 'constant.dart';

class CommonAlert {
  static final _alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    animationDuration: const Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: const BorderSide(
        color: Colors.white,
      ),
    ),
    titleStyle: const TextStyle(fontWeight: FontWeight.bold),
  );

  static DialogButton _dialogButton(
      context, String actionName, Function action) {
    return DialogButton(
      child: Text(
        actionName,
        style: const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      onPressed: action,
      width: 120,
    );
  }

  // Basic Alert
  static onAlert(context, AlertType alertType, String title, String desc) {
    Alert(
      context: context,
      style: _alertStyle,
      type: alertType,
      title: title,
      desc: desc,
    ).show();
  }

  static onAlertButtonPressed(context, AlertType alertType, String actionName,String title,String desc, Function action) {
    Alert(
      context: context,
      style: _alertStyle,
      type: alertType,
      title: title,
      desc: desc,
      buttons: [_dialogButton(context, actionName, action)],
    ).show();
  }

  static onAlertButtonsPressed(context, AlertType alertType, Function yesAction,
      Function noAction, String title,
      {String desc, AnimationType animationType}) {
    Alert(
      context: context,
      style: _alertStyle,
      type: alertType,
      title: title,
      desc: desc,
      buttons: [
        _dialogButton(context, 'Yes', yesAction),
        _dialogButton(context, 'No', noAction)
      ],
    ).show();
  }

  static onAlertWithImage(context, AlertType alertType, Image img, String title,
      {String desc}) {
    Alert(
      context: context,
      type: alertType,
      style: _alertStyle,
      title: title,
      desc: desc,
      image: img,
    ).show();
  }

  static onAlertClipboard(context, String title, Function actionYes) {
    Alert(
        context: context,
        title: title,
        style: _alertStyle,
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter stateSetter) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: <Widget>[
                  Divider(
                    height: 2,
                    color: AppColors.colorBlack,
                  ),
                  Container(
                    width: CommonMethods.screenWidth,
                    child: Text(
                      Strings.dialog_desc,
                      style: const TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        buttons: [
          DialogButton(
            color: AppColors.colorPrimary,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            color: AppColors.colorPrimary,
            onPressed: actionYes,
            child: const Text(
              "Yes",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
