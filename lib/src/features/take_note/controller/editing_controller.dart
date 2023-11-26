import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:timeline/src/features/take_note/controller/editor_state.dart';
import 'package:timeline/src/features/take_note/repository/editor_repo.dart';

import '../models/note_model.dart';

class EditorControllerNotifier extends StateNotifier<EditingState> {
  final EditingState editState;
  final EditorRepository repo;

  EditorControllerNotifier({
    required this.editState,
    required this.repo,
  }) : super(editState) {
    fetchNotes();
  }
  void noteAction() {
    switch (state.mode) {
      case EditMode.newNote:
        saveNewNotes();
        break;
      case EditMode.update:
        updateNote(state.model);
        break;
      default:
        saveNewNotes();
    }
  }

  void saveNewNotes() {
    String data = jsonEncode(state.controller.document.toDelta().toJson());
    DateTime time = DateTime.now();
    state = state.copyWith(model: NoteModel(note: data, edited: time));
    repo.addNote(state.model);
    fetchNotes();
  }

  void updateNote(NoteModel note) {
    final doc = Document.fromJson(
      jsonDecode(state.model.note),
    );
    state = state.copyWith(
      controller: QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
      ),
    );
    final updated =
        state.model.copyWith(note: state.model.note, id: state.model.id);
    repo.updateNote(updated);
    fetchNotes();
  }

  void fetchNotes() async {
    final getNote = await repo.getAllNotes();
    state = state.copyWith(notes: getNote);
  }

  void editMode(EditMode value) {
    state = state.copyWith(mode: value);
  }

  Future<void> deleteNote(int id) async {
    await repo.deleteNote(id);
    fetchNotes();
  }
}

final noteController =
    StateNotifierProvider<EditorControllerNotifier, EditingState>((ref) {
  final editState = EditingState(
      model: NoteModel(note: ''),
      locale: 'en',
      controller: QuillController.basic(),
      notes: [],
      mode: EditMode.newNote);
  final repo = ref.read(editorRepoProvider);
  return EditorControllerNotifier(editState: editState, repo: repo);
});
