import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  Database? _db;

  // to check if the database is created or not if not it creates a new database
  Future<Database?> get myDatabase async {
    if (_db == null) {
      _db = await initializeDatabaseFunction();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> initializeDatabaseFunction() async {
    String dbPath = await getDatabasesPath();
    String dbName = join(dbPath, 'noteTodo.db'); // to join ==> path/noteTodo.db
    Database database = await openDatabase(
      dbName,
      version: 1,
      onCreate: createDatabase,
    );
    return database;
  }

  // for create multiple table one for todo and other for note
  Future createDatabase(Database db, int version) async {
    var batchVariable = db.batch();
    batchVariable.execute('''
    CREATE TABLE todo (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        time TEXT,
        date TEXT,
        status TEXT
    )
      ''');
    batchVariable.execute('''
    CREATE TABLE notes (
        id INTEGER PRIMARY KEY,
        title TEXT,
        description TEXT,
        image TEXT
    )
      ''');
    await batchVariable.commit();
  }

  Future deleteDatabaseFunction() async {
    String dbPath = await getDatabasesPath();
    String dbName = join(dbPath, 'noteTodo.db');
    return await deleteDatabase(dbName);
  }

  // read ,insert, update and delete data
  Future<List> readData(String sql) async {
    Database? myDb = await myDatabase;
    List<Map> res = await myDb!.rawQuery(sql);
    return res;
  }

  Future<int> insertData(String sql) async {
    Database? myDb = await myDatabase;
    int res = await myDb!.rawInsert(sql);
    return res;
  }

  Future<int> updateData(String sql) async {
    Database? myDb = await myDatabase;
    int res = await myDb!.rawUpdate(sql);
    return res;
  }

  Future<int> deleteData(String sql) async {
    Database? myDb = await myDatabase;
    int res = await myDb!.rawDelete(sql);
    return res;
  }
}
