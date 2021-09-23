import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'waluty.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE waluty(id TEXT PRIMARY KEY, name TEXT, rate TEXT, fromCurrency TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<void> remove(String table, String id) async {
    final db = await DBHelper.database();
    db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  static Future<void> update(
      String table, String id, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.update(table, data,
        where: "id = ?",
        whereArgs: [id],
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
