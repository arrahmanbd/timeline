import 'package:flutter/material.dart';
import 'package:timeline/src/features/editor/screens/editor_screen.dart';
import 'package:timeline/src/features/home/screens/homepage.dart';
import 'package:timeline/src/features/lock/screens/lock_screen.dart';
import 'package:timeline/src/features/onboarding/screens/onBoarding.dart';

import '../features/settings/screen/setting_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OnBoarding.routeName:
      return MaterialPageRoute(
        builder: (context) => const OnBoarding(),
      );
    case LockScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => LockScreen(),
      );
    case MyTimeLine.routeName:
      return MaterialPageRoute(
        builder: (context) => const MyTimeLine(),
      );
    case EditorScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => EditorScreen(),
      );
    case SettingScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => SettingScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('This page doesn\'t exist')),
        ),
      );
  }
}
