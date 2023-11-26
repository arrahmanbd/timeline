import 'package:flutter_quill/flutter_quill.dart';

import '../models/note_model.dart';

enum EditMode { newNote, update }

class EditingState {
  final NoteModel model;
  final String locale;
  final QuillController controller;
  final List<NoteModel> notes;
  final EditMode mode;
  EditingState({
    required this.model,
    required this.locale,
    required this.controller,
    required this.notes,
    required this.mode,
  });

  EditingState copyWith({
    NoteModel? model,
    String? locale,
    QuillController? controller,
    List<NoteModel>? notes,
    EditMode? mode,
  }) {
    return EditingState(
      model: model ?? this.model,
      locale: locale ?? this.locale,
      controller: controller ?? this.controller,
      notes: notes ?? this.notes,
      mode: mode ?? this.mode,
    );
  }
}
