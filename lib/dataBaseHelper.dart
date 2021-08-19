import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
class dataBaseHelper {
  var databasesPath;
  var dbPath;
  var _database;
  static String table = 'movieDetails';
  static var movieNames='movies';
  static var directorNames='director';
  static var imageUrls='images';
  dataBaseHelper._privateConstructor();

  static final dataBaseHelper instance = dataBaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initdb();
    return _database;
  }

  _initdb() async {
    databasesPath = await getDatabasesPath();
    dbPath = join(databasesPath, 'myDB.db');
    return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $table($movieNames TEXT,$directorNames TEXT,$imageUrls String)');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }
  Future<int> update(Map<String,dynamic>row,var prevMovie)async{
    Database db=await instance.database;
    return db.update(table, row,where: '$movieNames=?',whereArgs: [prevMovie]);
  }
  Future<int> delete(var movieName) async{
    Database db=await instance.database;
    return db.delete(table,where: '$movieNames=?',whereArgs: [movieName]);
  }
  static Future<List> showTable() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table');
  }
  static Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

}
