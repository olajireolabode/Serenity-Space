import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'users.dart';

class DatabaseHelper{
  static final _databaseName = 'registration.db';
  static final _databaseversion = 1;

  static final table = 'register_table';

  static final columnId = 'id';
  static final columnEmail = 'email';
  static final columnPassword = 'password';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    //lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }
  Future _onCreate (Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnEmail TEXT NOT NULL, 
    $columnPassword TEXT NOT NULL 
    )
    ''');
  }
  Future<int?> insert(User user) async {
    Database? db = await instance.database;
    return await db?.insert(table, {'email' : user.email, 'password': user.password});
  }
  // all rows are returned as a list of maps, where each map is
  // a key-value list of columns
  Future<List<Map<String, dynamic>>?> queryAllRows() async {
    Database? db = await instance.database;
    return await db?.query(table);

  }
  Future<bool> validateUserCredentials(String email, String password) async {
    Database? db = await instance.database;

    if (db == null) {
      print("Databse is empty");
      return false;
    }
    // Query the database to check if the user exists
    List<Map<String, dynamic>> result = await db!.query(
      table,
      where: '$columnEmail = ? AND $columnPassword = ?',
      whereArgs: [email, password],
    );

    // If the result contains any rows, the user is registered
    return result.isNotEmpty;
  }
}