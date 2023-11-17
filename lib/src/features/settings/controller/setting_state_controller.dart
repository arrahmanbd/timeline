import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_state.dart';

class SettingNotifier extends StateNotifier<SettingState> {
  SettingNotifier()
      : super(SettingState(isDark: false, isExpand: false, isOnboard: false));

  void isDark(bool value) {
    state = state.copyWith(isDark: value);
  }

  void isExpand(bool value) {
    state = state.copyWith(isExpand: value);
  }
}

final settingProvider =
    StateNotifierProvider<SettingNotifier, SettingState>((ref) {
  return SettingNotifier();
});
