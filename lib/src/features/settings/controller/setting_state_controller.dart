import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/features/lock_screen/controllers/lock_screen_controller.dart';

import 'package:timeline/src/features/lock_screen/controllers/lockscreen_state.dart';

import '../../../helper/shared_preference.dart';
import 'settings_state.dart';

class SettingNotifier extends StateNotifier<SettingState> {
  final SharedPreferencesService prefs;
  final SettingState states;
  SettingNotifier({
    required this.prefs,
    required this.states,
  }) : super(states);

  // ToggleAndSave state
  void toggleTheme(bool value) {
    state = state.copyWith(isDark: value);
    prefs.isDarkMode = value;
  }

  void isExpand(bool value) {
    state = state.copyWith(isExpand: value);
    prefs.isExpand = value; // Save to SharedPreferences
  }

  void isBottom(bool value) {
    state = state.copyWith(isBottom: value);
    prefs.isBottom = value; // Save to SharedPreferences
  }

  void editorLanguage(String? value) {
    state = state.copyWith(editorlang: value);
    prefs.editorLanguage = value; // Save to SharedPreferences
  }

  void onBoarding(bool value) {
    state = state.copyWith(isOnboard: value);
    prefs.isOnboard = value; // Save to SharedPreferences
  }

  void changeAnimation(AnimationType? value) {
    state = state.copyWith(animation: value);
    prefs.animation = value.toString(); // Save to SharedPreferences
  }
}

final settingProvider =
    StateNotifierProvider<SettingNotifier, SettingState>((ref) {
  final prefs = ref.read(sharedProvider);
  final settingState = SettingState(
      isDark: prefs.isDarkMode,
      isExpand: prefs.isExpand,
      isBottom: prefs.isBottom,
      editorlang: prefs.editorLanguage ?? 'en',
      isOnboard: prefs.isOnboard,
      animation: AnimationType.fade);
  return SettingNotifier(
    prefs: prefs,
    states: settingState,
  );
});
