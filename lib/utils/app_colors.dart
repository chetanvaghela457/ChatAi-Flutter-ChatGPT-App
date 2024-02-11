import 'package:flutter/material.dart';

class AppColors {

  static var isDark = false;
  static var isPortrait = false;

  static void updateColor(BuildContext context) {
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    isDark = brightnessValue == Brightness.dark;
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static MaterialColor get colorPrimary {
    return isDark ? MaterialColor(0xFF0E0F34, color) : MaterialColor(0xFF0E0F34, color);
  }

  static MaterialColor get colorRed {
    return isDark ? MaterialColor(0xFFFF0000, color) : MaterialColor(0xFFFF0000, color);
  }

  static MaterialColor get colorGrey {
    return isDark ? MaterialColor(0xFF808080, color) : MaterialColor(0xFF808080, color);
  }

  static MaterialColor get colorWhite {
    return isDark ? MaterialColor(0xFFFFFFFF, color) : MaterialColor(0xFFFFFFFF, color);
  }

  static MaterialColor get colorBlack {
    return isDark ? MaterialColor(0xFF000000, color) : MaterialColor(0xFF000000, color);
  }

  static Color get colorBlackWithAlpha {
    return isDark ? MaterialColor(0xFF000000, color).withAlpha(100) : MaterialColor(0xFF000000, color).withAlpha(100);
  }

  static MaterialColor get colorLightGrey {
    return isDark ? MaterialColor(0xFFD3D3D3, color) : MaterialColor(0xFFD3D3D3, color);
  }

  static MaterialColor get colorSkyBlue {
    return isDark ? MaterialColor(0xFF7BD3F7, color) : MaterialColor(0xFF7BD3F7, color);
  }
  static Color get colorClear {
    return Colors.white.withAlpha(0);
  }

  static MaterialColor get colorGreen {
    return isDark ? MaterialColor(0xFF008000, color) : MaterialColor(0xFF008000, color);
  }

}
Map<int, Color> color =
{
  50:Color.fromRGBO(136,14,79, .1),
  100:Color.fromRGBO(136,14,79, .2),
  200:Color.fromRGBO(136,14,79, .3),
  300:Color.fromRGBO(136,14,79, .4),
  400:Color.fromRGBO(136,14,79, .5),
  500:Color.fromRGBO(136,14,79, .6),
  600:Color.fromRGBO(136,14,79, .7),
  700:Color.fromRGBO(136,14,79, .8),
  800:Color.fromRGBO(136,14,79, .9),
  900:Color.fromRGBO(136,14,79, 1),
};

