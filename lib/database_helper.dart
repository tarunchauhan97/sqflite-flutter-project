import 'dart:io';

//import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
//singleton class by using one privateconstructor
//to create instance on any class we generally call constructor

  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'myTable';
  static final columnId = '_id';
  //id will be auto generated as it is the primary key
  static final columnName = 'name';

//making it singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initiateDatabase();
    return _database!;
  }

  _initiateDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _dbName);
    //String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future? _onCreate(Database db, int version) {
    db.execute(
        '''
        CREATE TABLE $_tableName( 
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL)
        '''
    );
  }

  Future<int?> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int> update(Map<String, dynamic> row) async {
    //it returns no. of rows updated
    //no. of rows that are affected

    Database db = await instance.database;
    //db.update(_tableName, row,where: '$columnId = ? $columnName = ?',whereArgs: [1,'tarun'] );
    //? will be replaced by wheresArgs list index mentioned
    //here we are using only id
    //db.update(_tableName, row,where: '$columnId = ? $columnName = ?',whereArgs: [1,'tarun'] );

    int id = row[columnId];

    return await db
        .update(_tableName, row, where: '$columnId = ? ', whereArgs: [id]);
    //it returns no. of rows updated
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
