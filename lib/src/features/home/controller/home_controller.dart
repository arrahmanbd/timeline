// note_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/note_model.dart';
import '../repository/home_repository.dart';

final noteProvider = ChangeNotifierProvider<NOteController>(
    (ref) => NOteController(DatabaseHelper()));

class NOteController extends ChangeNotifier {
  final DatabaseHelper _databaseHelper;
  List<String> notes = [];
  int index = 0;

  NOteController(this._databaseHelper);

  Future<List<Note>> getNotes() async {
    return _databaseHelper.getNotes();
  }

  Future<void> addNote(Note note) async {
    await _databaseHelper.addNote(note);
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    await _databaseHelper.deleteNote(id);
    notifyListeners();
  }

  add() {
    index++;
    notes.add(index.toString());
    notifyListeners();
  }

  clear() {
    notes.clear();
    index = 0;
    notifyListeners();
  }
}
