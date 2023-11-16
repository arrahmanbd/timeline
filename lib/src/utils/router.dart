import 'package:flutter/material.dart';
import 'package:timeline/src/features/editor/screens/editor.dart';
import 'package:timeline/src/features/editor/screens/editor_screen.dart';
import 'package:timeline/src/features/home/screens/homepage.dart';
import 'package:timeline/src/features/lock/screens/lock_screen.dart';
import 'package:timeline/src/features/onboarding/screens/onBoarding.dart';

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
    case MobileEditor.routeName:
      return MaterialPageRoute(
        builder: (context) => EditorScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('This page doesn\'t exist')),
        ),
      );
  }
}
