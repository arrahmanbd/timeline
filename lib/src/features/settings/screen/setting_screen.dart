import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/features/settings/widgets/setting_tile.dart';

import '../controller/setting_state_controller.dart';

class SettingScreen extends ConsumerWidget {
  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingProvider);
    void isDarkMode(bool value) {
      ref.read(settingProvider.notifier).isDark(value);
      print('Switch value: $value');
    }

    void isExpand(bool value) {
      ref.read(settingProvider.notifier).isExpand(value);
      print('Switch value: $value');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          SettingTile(
            title: 'Theme',
            info: 'Enable dark Mode',
            value: settings.isDark,
            fun: isDarkMode, // Pass the function here
          ),
          SettingTile(
            title: 'Expand Toolbox',
            info: 'Always expand Editor toolbox',
            value: settings.isExpand,
            fun: isExpand, // Pass the function here
          ),
        ],
      ),
    );
  }
}
