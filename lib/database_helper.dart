import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'entries.db';
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE entries (
        id INTEGER PRIMARY KEY,
        feeling TEXT,
        description TEXT,
        user_email TEXT
      )
    ''');
  }

  Future<int> insertEntry(Map<String, dynamic> entry) async {
    Database db = await instance.database;
    return await db.insert('entries', entry);
  }

  Future<List<Map<String, dynamic>>> getAllEntries(String email) async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM entries WHERE user_email=?', [email]);
  }
}
