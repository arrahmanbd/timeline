class SettingState {
  final bool isDark;
  final bool isExpand;
  final bool isOnboard;
  SettingState({
    required this.isDark,
    required this.isExpand,
    required this.isOnboard,
  });

  SettingState copyWith({
    bool? isDark,
    bool? isExpand,
    bool? isOnboard,
  }) {
    return SettingState(
      isDark: isDark ?? this.isDark,
      isExpand: isExpand ?? this.isExpand,
      isOnboard: isOnboard ?? this.isOnboard,
    );
  }
}
