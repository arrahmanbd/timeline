import 'dart:convert';

import 'package:animated_list_item/animated_list_item.dart';

class SettingState {
  final bool isDark;
  final bool isExpand;
  final bool isBottom;
  final String editorlang;
  final bool isOnboard;
  final AnimationType animation;
  SettingState({
    required this.isDark,
    required this.isExpand,
    required this.isBottom,
    required this.editorlang,
    required this.isOnboard,
    required this.animation,
  });

  SettingState copyWith({
    bool? isDark,
    bool? isExpand,
    bool? isBottom,
    String? editorlang,
    bool? isOnboard,
    AnimationType? animation,
  }) {
    return SettingState(
      isDark: isDark ?? this.isDark,
      isExpand: isExpand ?? this.isExpand,
      isBottom: isBottom ?? this.isBottom,
      editorlang: editorlang ?? this.editorlang,
      isOnboard: isOnboard ?? this.isOnboard,
      animation: animation ?? this.animation,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'isDark': isDark});
    result.addAll({'isExpand': isExpand});
    result.addAll({'isBottom': isBottom});
    result.addAll({'editorlang': editorlang});
    result.addAll({'isOnboard': isOnboard});
    result.addAll({'animation': animation});

    return result;
  }

  factory SettingState.fromMap(Map<String, dynamic> map) {
    return SettingState(
      isDark: map['isDark'] ?? false,
      isExpand: map['isExpand'] ?? false,
      isBottom: map['isBottom'] ?? false,
      editorlang: map['editorlang'] ?? '',
      isOnboard: map['isOnboard'] ?? false,
      animation: map['animation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingState.fromJson(String source) =>
      SettingState.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SettingState(isDark: $isDark, isExpand: $isExpand, isBottom: $isBottom, editorlang: $editorlang, isOnboard: $isOnboard, animation: $animation)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SettingState &&
        other.isDark == isDark &&
        other.isExpand == isExpand &&
        other.isBottom == isBottom &&
        other.editorlang == editorlang &&
        other.isOnboard == isOnboard &&
        other.animation == animation;
  }

  @override
  int get hashCode {
    return isDark.hashCode ^
        isExpand.hashCode ^
        isBottom.hashCode ^
        editorlang.hashCode ^
        isOnboard.hashCode ^
        animation.hashCode;
  }
}
