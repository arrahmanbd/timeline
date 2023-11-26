import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/features/lock_screen/controllers/lock_screen_controller.dart';
import 'package:timeline/src/features/settings/widgets/setting_drop.dart';
import 'package:timeline/src/features/settings/widgets/setting_tile.dart';
import 'package:timeline/src/utils/utils.dart';

import '../controller/setting_state_controller.dart';

class SettingScreen extends ConsumerWidget {
  static const String routeName = '/settings';
  final List<String> editorLanguages = ['ar', 'bn', 'en'];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingProvider);
    final enableLock = ref.watch(lockProvider).enableLock;
    void isDarkMode(bool value) {
      ref.read(settingProvider.notifier).toggleTheme(value);
      print('Switch value: $value');
    }

    void isExpand(bool value) {
      ref.read(settingProvider.notifier).isExpand(value);
      print('Switch value: $value');
    }

    void isBottom(bool value) {
      ref.read(settingProvider.notifier).isBottom(value);
      print('Switch value: $value');
    }

    void locker(bool value) {
      ref.read(lockProvider.notifier).setLock(value);
      print('Lock value: $value');
    }

    void editorLang(String? value) {
      ref.read(settingProvider.notifier).editorLanguage(value);
      Utils.showSnackBar(content: 'Language set to ${value}', context: context);
    }

    void changeAnimate(AnimationType? value) {
      ref.read(settingProvider.notifier).changeAnimation(value);
      Utils.showSnackBar(
          content: 'Animation set to ${value}', context: context);
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
          SettingTile(
            title: 'Bottom Toolbar',
            info: 'Place Editor toolbox at Bottom',
            value: settings.isBottom,
            fun: isBottom, // Pass the function here
          ),
          SettingTile(
            title: enableLock ? 'Disable lock Screen' : 'Enable Lock Screen',
            info: 'Place Editor toolbox at Bottom',
            value: enableLock,
            fun: locker, // Pass the function here
          ),
          SettingDropTile(
              title: 'Toolbar Language',
              info: 'Select toolbox Language',
              value: settings.editorlang,
              fun: editorLang,
              languages: editorLanguages // Pass the function here
              ),
          ListTile(
            title: Text('Change animation'),
            subtitle: Text('Set default animation'),
            trailing: Transform.scale(
                scale: 1,
                child: DropdownButton<AnimationType>(
                  elevation: 1,
                  value: settings.animation,
                  onChanged: (AnimationType? newValue) =>
                      changeAnimate(newValue),
                  items: AnimationType.values
                      .map<DropdownMenuItem<AnimationType>>(
                          (AnimationType value) {
                    return DropdownMenuItem<AnimationType>(
                      value: value,
                      child: Text(value.name),
                    );
                  }).toList(),
                )),
          ),
        ],
      ),
    );
  }
}
