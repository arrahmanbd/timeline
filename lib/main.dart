import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/features/backup_notes/controllers/backup_controller.dart';
import 'package:timeline/src/features/lock_screen/controllers/lock_screen_controller.dart';
import 'package:timeline/src/features/lock_screen/screens/lock_screen.dart';
import 'package:timeline/src/features/onboarding/screens/onBoarding.dart';
import 'package:timeline/src/features/settings/controller/setting_state_controller.dart';
import 'package:timeline/src/utils/router.dart';

import 'src/core/themes.dart';
import 'src/features/home_screen/screens/homepage.dart';
import 'src/helper/shared_preference.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService().init();
  Backup.fileInfo();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(settingProvider);
    final isLocked = ref.watch(lockProvider).enableLock;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TimeLine',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: config.isDark ? ThemeMode.dark : ThemeMode.light,
      home: config.isOnboard
          ? const OnBoarding()
          : isLocked
              ? LockScreen()
              : MyTimeLine(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
