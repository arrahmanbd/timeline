import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/features/home/screens/homepage.dart';
import 'package:timeline/src/features/settings/screen/setting_screen.dart';
import 'package:timeline/src/utils/router.dart';

main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TimeLine',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: MyTimeLine(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
