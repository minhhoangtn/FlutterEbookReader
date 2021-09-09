import 'dart:io';

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';

class PinnedDB {
  static Future<Database> dataBase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final dbPath = path.join(documentsDirectory.path, 'favorites.db');
    return sql.openDatabase(dbPath, version: 1, onCreate: (db, version) async {
      return db.execute(
          'CREATE TABLE favorite_books(id TEXT PRIMARY KEY, entry TEXT)');
    });
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await PinnedDB.dataBase();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> delete(String table, String id) async {
    final db = await PinnedDB.dataBase();
    db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<bool> check(String table, String id) async {
    final db = await PinnedDB.dataBase();
    final List<Map<String, Object?>> list =
        await db.query(table, where: 'id = ?', whereArgs: [id]);
    if (list.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Map<String, Object?>>> queryAll(String table) async {
    final db = await PinnedDB.dataBase();
    final List<Map<String, Object?>> list = await db.query(table);
    return list;
  }
}
