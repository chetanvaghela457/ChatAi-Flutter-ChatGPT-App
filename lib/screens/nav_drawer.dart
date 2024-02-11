import 'package:chatai/screens/category_item_screen.dart';
import 'package:chatai/screens/home_screen.dart';
import 'package:chatai/screens/lets_chat_screen.dart';
import 'package:chatai/screens/settings_screen.dart';
import 'package:chatai/utils/app_colors.dart';
import 'package:chatai/utils/constant.dart';
import 'package:chatai/utils/strings.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key key}) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> with WidgetsBindingObserver {
  DateTime currentBackPressTime;

  @override
  void initState() {
    showRatingBar(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: children()[_current]),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        backgroundColor: AppColors.colorWhite,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColors.colorGrey,
        selectedItemColor: AppColors.colorPrimary,
        currentIndex: _current,
        onTap: _change,
        items: items,
      ),
    );
  }

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home), label: Strings.home),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.chat_bubble), label: Strings.history),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.group), label: Strings.categories),
    BottomNavigationBarItem(
        icon: Icon(Icons.more_horiz), label: Strings.settings)
  ];

  int _current = 0;

  void _change(int index) {
    setState(() {
      _current = index;
    });
  }

  List<Widget> children() {
    return [
      HomeScreen(),
      LetsChatScreen(),
      CategoriesScreen(),
      SettingScreen()
    ];
  }
}
