class EditingState {
  final String note;
  final String tag;
  final String locale;
  EditingState({
    required this.note,
    required this.tag,
    required this.locale,
  });

  EditingState copyWith({
    String? note,
    String? tag,
    String? locale,
  }) {
    return EditingState(
      note: note ?? this.note,
      tag: tag ?? this.tag,
      locale: locale ?? this.locale,
    );
  }
}
