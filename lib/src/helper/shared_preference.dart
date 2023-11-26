import 'dart:convert';

import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/settings/controller/settings_state.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();

  late SharedPreferences _prefs;

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Getter and Setter for isDarkMode
  bool get isDarkMode => _prefs.getBool('isDarkMode') ?? false;

  set isDarkMode(bool value) {
    _prefs.setBool('isDarkMode', value);
  }

  // Getter and Setter for isDarkMode
  bool get enableLock => _prefs.getBool('enableLock') ?? false;
  set enableLock(bool value) => _prefs.setBool('enableLock', value);

  // Getter and Setter for Lock
  bool get isLocked => _prefs.getBool('isLocked') ?? false;

  set isLocked(bool value) {
    _prefs.setBool('isLocked', value);
  }

  // Getter and Setter for passCode
  String? get passCode => _prefs.getString('passCode');
  set passCode(String? value) {
    _prefs.setString('passCode', value ?? '');
  }

  // Getter and Setter for isExpand
  bool get isExpand => _prefs.getBool('isExpand') ?? false;

  set isExpand(bool value) {
    _prefs.setBool('isExpand', value);
  }

  // Getter and Setter for isBottom
  bool get isBottom => _prefs.getBool('isBottom') ?? false;

  set isBottom(bool value) {
    _prefs.setBool('isBottom', value);
  }

  // Getter and Setter for isBottom
  String get animation => _prefs.getString('animation') ?? '';

  set animation(String value) {
    _prefs.setString('animation', value);
  }

  // Getter and Setter for editorLanguage
  String? get editorLanguage => _prefs.getString('editorLanguage');

  set editorLanguage(String? value) {
    _prefs.setString('editorLanguage', value ?? 'en');
  }

  // Getter and Setter for isOnboard
  bool get isOnboard => _prefs.getBool('isOnboard') ?? true;

  set isOnboard(bool value) {
    _prefs.setBool('isOnboard', value);
  }

  //Or another method is using Json
  // Save the SettingState to SharedPreferences
  void saveSettingState(SettingState settingState) {
    final jsonString = jsonEncode(settingState.toJson());
    _prefs.setString('settingState', jsonString);
  }

  // Retrieve the SettingState from SharedPreferences
  SettingState getSettingState() {
    final jsonString = _prefs.getString('settingState');
    if (jsonString != null) {
      return SettingState.fromJson(jsonDecode(jsonString));
    }
    return SettingState(
      isDark: false,
      isExpand: false,
      isBottom: false,
      editorlang: 'en',
      isOnboard: false,
      animation: AnimationType.fade,
    );
  }
}

final sharedProvider = Provider<SharedPreferencesService>((ref) {
  return SharedPreferencesService();
});
