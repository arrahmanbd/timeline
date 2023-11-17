import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/features/editor/controller/editor_state.dart';

class EditorControllerNotifier extends StateNotifier<EditingState> {
  EditorControllerNotifier()
      : super(EditingState(note: '', tag: '', locale: 'bn'));

  void pickNote(String note) {
    state = state.copyWith(note: note);
  }

  QuillController openNote(QuillController controller) {
    String data = state.note;
    print(data);
    Document? doc;

    try {
      doc = Document.fromJson(jsonDecode(data));
    } catch (e) {
      print('Error decoding JSON: $e');
      // Handle the error appropriately, e.g., log, show a message, etc.
      // You might want to provide a default value or inform the user about the error.
    }

    controller = QuillController(
      document: doc ?? Document(), // Provide a default value if doc is null
      selection: const TextSelection.collapsed(offset: 0),
    );

    return controller;
  }
}

final editorProvider =
    StateNotifierProvider<EditorControllerNotifier, EditingState>((ref) {
  return EditorControllerNotifier();
});
