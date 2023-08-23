import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase4.db";
  static final _databaseVersion = 6;

  //static final durak = 'durak';

  static final table = 'users';
  static final table2 = 'stops';
  static final table3 = 'otobus';

  static final columnId = '_iduser';
  static final columnType = 'type';
  static final columnName = 'nameuser';
  static final columnPass = 'pass';

  static final columnBus1 = 'bus1';
  static final columnBus2 = 'bus2';
  static final columnBus3 = 'bus3';

  static final columnIdDurak = '_id';
  static final columnNameDurak = 'name';
  static final columnLatDurak = 'lat';
  static final columnLngDurak = 'lng';
  static final columnYolcuDurak = 'yolcu';

  static final columnYolcuIsim = 'yolcuisim';
  static final columnYolcuSayi = 'sayi';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {

   await db.execute('''
          CREATE TABLE $table2 (
            $columnIdDurak INTEGER PRIMARY KEY,
            $columnNameDurak TEXT NOT NULL,
            $columnLatDurak TEXT NOT NULL,
            $columnLngDurak TEXT NOT NULL,
            $columnYolcuDurak TEXT NOT NULL
          )
          ''');

    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnType TEXT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnPass TEXT NOT NULL
          )
          ''');

   await db.execute('''
          CREATE TABLE $table3 (
            $columnBus1 TEXT NOT NULL,
            $columnBus2 TEXT NOT NULL,
            $columnBus3 TEXT NOT NULL
          )
          ''');
  }

  Future<int?> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(table, row);
  }

  Future<int?> insert3(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(table3, row);
  }

  Future<int?> insert2(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    print(row[columnIdDurak]);
    return await db?.insert(table2, row);
  }

  Future<List<Map<String, dynamic>>?> queryAllRows() async {
    Database? db = await instance.database;
    return await db?.query(table2);
  }

  Future<List<Map<String, dynamic>>?> queryAllRows2() async {
    Database? db = await instance.database;
    return await db?.query(table);
  }

  Future<List<Map<String, dynamic>>?> queryAllRows3() async {
    Database? db = await instance.database;
    return await db?.query(table3);
  }

  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $table2'));
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = int.parse(row[columnIdDurak]);
    print(row[columnIdDurak]);
    return await db!.update(table2, row, where: '$columnIdDurak = ?', whereArgs: [id]);
  }

  Future<int> update2(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    String id = row[columnNameDurak];
    print(row[columnIdDurak]);
    return await db!.update(table2, row, where: '$columnNameDurak = ?', whereArgs: [id]);
  }

  Future<int> update3(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.update(table3, row);
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table2, where: '$columnIdDurak = ?', whereArgs: [id]);
  }

  Future<int> delete2(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table3);
  }


/////////////////////////////////////////////////////////////////////////////////


  Future<int?> LoginTest() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery("SELECT COUNT(*) FROM $table WHERE nameuser='burak' and pass='emir'"));
  }

}
