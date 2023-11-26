import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:timeline/src/features/lock_screen/controllers/lockscreen_state.dart';
import 'package:timeline/src/helper/shared_preference.dart';

class LockScreenNotifier extends StateNotifier<LockScreenState> {
  final LockScreenState lockState;
  final SharedPreferencesService prefs;
  LockScreenNotifier(
    this.lockState,
    this.prefs,
  ) : super(lockState) {}

  void checkLock(String passCode) {
    print(passCode + '==' + prefs.passCode.toString());
    if (prefs.passCode == null || prefs.passCode == '') {
      state =
          state.copyWith(isNewUser: true, passCode: passCode, isSuccess: true);
      prefs.passCode = passCode.toString();
    } else if (prefs.passCode != '' && prefs.passCode == passCode) {
      state = state.copyWith(
        isNewUser: false,
        isSuccess: true,
      );
    } else {
      state = state.copyWith(isError: true);
    }
  }

  void setLock(bool value) {
    state = state.copyWith(enableLock: value);
    print('set locked from another provider');
    prefs.enableLock = value;
  }

  Future checknewUser() async {
    if (prefs.passCode == null || prefs.passCode == '') {
      state = state.copyWith(isNewUser: true);
    } else {
      state = state.copyWith(isNewUser: false);
    }
  }
}

final lockProvider =
    StateNotifierProvider<LockScreenNotifier, LockScreenState>((ref) {
  final prefs = ref.read(sharedProvider);
  final state = LockScreenState(
    enableLock: prefs.enableLock,
    isSuccess: false,
    isError: false,
    isNewUser: false,
    passCode: prefs.passCode.toString(),
  );
  return LockScreenNotifier(state, prefs);
});
