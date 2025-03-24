import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user.dart';

class DatabaseHelper {
  static final DatabaseHelper databaseHelperInstance =
      DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  // Getter for the database
  Future<Database> get db async {
    // If _database is null initialize it otherwise do nothing
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'geeksforgeeks.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // The 'db' parameter is the Database instance provided by sqflite
    // The 'version' parameter contains the version number (1) from openDatabase call

    // Execute SQL to create the users table when database is first created
    await db.execute('''
      CREATE TABLE gfg_users (
        id INTEGER PRIMARY KEY,
        username TEXT,
        email TEXT
      )
    ''');
    // This function only runs once when the database file is first created
  }

  Future<int> insertUser(User user) async {
    Database db = await databaseHelperInstance.db;
    return await db.insert('gfg_users', user.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    Database db = await databaseHelperInstance.db;
    return await db.query('gfg_users');
  }

  Future<Map<String, dynamic>> queryUser(int id) async {
    Database db = await databaseHelperInstance.db;
    List<Map<String, dynamic>> result = await db.query(
      'gfg_users',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.first;
  }

  Future<int> updateUser(User user) async {
    Database db = await databaseHelperInstance.db;
    return await db.update(
      'gfg_users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    Database db = await databaseHelperInstance.db;
    return await db.delete('gfg_users', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllUsers() async {
    Database db = await databaseHelperInstance.db;
    return await db.delete('gfg_users');
  }

  Future<void> initializeUsers() async {
    List<User> usersToAdd = [
      User(username: 'John', email: 'john@example.com'),
      User(username: 'Jane', email: 'jane@example.com'),
      User(username: 'Alice', email: 'alice@example.com'),
      User(username: 'Bob', email: 'bob@example.com'),
    ];

    for (User user in usersToAdd) {
      await insertUser(user);
    }
  }
}
