import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DownloadDB {
  static Future<Database> dataBase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final dbPath = path.join(documentDirectory.path, 'download.db');
    return await sql.openDatabase(dbPath, version: 1,
        onCreate: (db, version) async {
      return await db.execute(
          'CREATE TABLE download_books(id TEXT PRIMARY KEY, path TEXT, size REAL, imageUrl TEXT, title TEXT, author TEXT)');
    });
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DownloadDB.dataBase();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> delete(String table, String id) async {
    final db = await DownloadDB.dataBase();
    db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<Object?> getBookPath(String table, String id) async {
    final db = await DownloadDB.dataBase();
    List<Map<String, Object?>> list =
        await db.query(table, where: 'id = ?', whereArgs: [id]);
    if (list.isEmpty) return null;
    return list[0]['path'];
  }

  static Future<List<Map<String, Object?>>> queryAll(String table) async {
    final db = await DownloadDB.dataBase();
    List<Map<String, Object?>> list = await db.query(table);
    return list;
  }
}
