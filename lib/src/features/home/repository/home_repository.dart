// database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../model/note_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  late Database _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'notes_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, note TEXT, time TEXT, labels TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<List<Note>> getNotes() async {
    final List<Map<String, dynamic>> maps = await _database.query('notes');
    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        title: maps[i]['title'],
        note: maps[i]['note'],
        time: DateTime.parse(maps[i]['time']),
        labels: maps[i]['labels'].split(','),
      );
    });
  }

  Future<void> addNote(Note note) async {
    await _database.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteNote(int id) async {
    await _database.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
