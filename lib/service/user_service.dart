import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_bachelor/database/database_helper.dart';

class UserService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
  }

  Future<int> registerUser(String username, String password) async {
    final db = await _dbHelper.database;
    return await db.insert('users', {'username': username, 'password': password});
  }

  Future<bool> loginUser(String username, String password) async {
    final db = await _dbHelper.database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return result.isNotEmpty;
  }
}
