import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timeline/src/extensions/extensions.dart';

class Backup {
  static Future<void> fileInfo() async {
    // Get the application documents directory
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'notes.db');
    print(path);
    File file = File(path);
    if (file.existsSync()) {
      var fileStat = file.statSync();
      print('File Information:');
      print('File Name: ${file.path}');
      print('File Size (bytes): ${fileStat.size}');
      print('Last Modified Time: ${fileStat.modified}');
      print('Accessed Time: ${fileStat.accessed}');
      print('Creation Time: ${fileStat.changed.formatTimeAndDay()}');
      print('Is Directory: ${fileStat.type == FileSystemEntityType.directory}');
      print('Is File: ${fileStat.type == FileSystemEntityType.file}');
    } else {
      print('The file at $path does not exist.');
    }
  }
}
