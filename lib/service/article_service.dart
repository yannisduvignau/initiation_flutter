import 'package:sqflite/sqflite.dart';
import 'package:flutter_application_bachelor/database/database_helper.dart';

class ArticleService {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Create the `articles` table if it does not exist.
  Future<void> createTable(Database db) async {
    try {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS articles (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT NOT NULL
        )
      ''');
    } catch (e) {
      // Log or handle the error if needed
      print('Error creating table: $e');
    }
  }

  /// Insert a new article into the `articles` table.
  Future<int> insertArticle(Map<String, dynamic> article) async {
    try {
      final db = await _dbHelper.database;
      return await db.insert(
        'articles',
        article,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      // Log or handle the error if needed
      print('Error inserting article: $e');
      return 0; // Return 0 to indicate failure
    }
  }

  /// Retrieve all articles from the `articles` table.
  Future<List<Map<String, dynamic>>> getArticles() async {
    try {
      final db = await _dbHelper.database;
      return await db.query('articles');
    } catch (e) {
      // Log or handle the error if needed
      print('Error retrieving articles: $e');
      return []; // Return an empty list to indicate no results
    }
  }

  /// Delete an article from the `articles` table by ID.
  Future<bool> deleteArticle(int id) async {
    try {
      final db = await _dbHelper.database;
      final rowsDeleted = await db.delete(
        'articles',
        where: 'id = ?',
        whereArgs: [id],
      );
      return rowsDeleted > 0; // Return true if an article was deleted
    } catch (e) {
      // Log or handle the error if needed
      print('Error deleting article: $e');
      return false; // Return false to indicate failure
    }
  }

  /// Update an article in the `articles` table.
  Future<bool> updateArticle(Map<String, dynamic> article) async {
    try {
      final db = await _dbHelper.database;
      final rowsUpdated = await db.update(
        'articles',
        article,
        where: 'id = ?',
        whereArgs: [article['id']],
      );
      return rowsUpdated > 0; // Return true if an article was updated
    } catch (e) {
      // Log or handle the error if needed
      print('Error updating article: $e');
      return false; // Return false to indicate failure
    }
  }
}
