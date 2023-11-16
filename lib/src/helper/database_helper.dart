import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final databaseHelpProvider = Provider<DatabaseHelper>((ref) {
  return DatabaseHelper();
});

class DB {
  static final DB _db = DB._internal();
  DB._internal();
  static DB get instance => _db;
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _init();
    return _database;
  }

  Future<Database> _init() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'database_name.db'),
      onCreate: _createSchema,
      version: 5,
    );
  }

  // Creating database schema
  static Future<void> _createSchema(Database db, int version) async {
    print('Schema CReating');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS notes(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    note TEXT,
    time INTEGER,
    label TEXT
    ) 
    ''');
  }
}

class DatabaseHelper {
  // Private Factory Constructor for instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'database.db');
    // Open the database
    return await openDatabase(dbPath, version: 1, onCreate: _createSchema);
  }

  // Closing the database
  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  // Creating database schema
  static Future<void> _createSchema(Database db, int version) async {
    print('Schema CReating');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS notes(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    note TEXT,
    time INTEGER,
    label TEXT
    ) 
    ''');
  }
}
