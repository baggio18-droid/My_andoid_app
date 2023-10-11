import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  Future<void> initDatabase() async {
    if (_database != null) {
      return;
    }
    String path = join(await getDatabasesPath(), 'your_database_name.db');
    _database = await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS income (
        id INTEGER PRIMARY KEY,
        date TEXT,
        amount REAL,
        description TEXT
      )
    ''');
  }

  Future<int> insertIncome(Map<String, dynamic> income) async {
    return await _database!.insert('income', income);
  }

  // Other methods for CRUD operations can be added as needed

  // ...

}
