import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_application_bachelor/service/article_service.dart';
import 'package:flutter_application_bachelor/service/user_service.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final fullPath = join(dbPath, fileName);

    return await openDatabase(
      fullPath,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Crée les tables via les services
    await ArticleService().createTable(db);
    await UserService().createTable(db);
  }

  void deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');
    await deleteDatabase(path);
    print('Database deleted');
  }
}
