import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../helper/database_helper.dart';
import '../models/note_model.dart';

class EditorRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<NoteModel>> getAllNotes() async {
    final List<Map<String, dynamic>> data =
        await _databaseHelper.query('users');
    final notes = data.map((e) => NoteModel.fromMap(e)).toList();
    return notes;
  }

  Future<void> addNote(NoteModel note) async {
    await _databaseHelper.insert(
        'users', note.toMap()); // Refresh the state after adding a new user
  }

  Future<void> updateNote(NoteModel note) async {
    await _databaseHelper.update('users', note.toMap(), 'id = ?', [note.id]);
    //await getUsers(); // Refresh the state after updating a user
  }

  Future<void> deleteNote(int? noteId) async {
    await _databaseHelper.delete('users', 'id = ?', [noteId]);
    //await getUsers(); // Refresh the state after deleting a user
  }

  Future<List<NoteModel>> searchUsers(String keyword) async {
    final List<Map<String, dynamic>> data = await _databaseHelper
        .search('users', where: 'note LIKE ?', whereArgs: ['%$keyword%']);
    return data.map((map) => NoteModel.fromMap(map)).toList();
  }
}

final editorRepoProvider = StateProvider<EditorRepository>((ref) {
  return EditorRepository();
});
