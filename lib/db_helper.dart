// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:daily_task/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class Dbhelper {
  Dbhelper.privateConstructor();
  static final instance = Dbhelper.privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await intialized();
    return _database;
  }

  intialized() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, "mydb.db");
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  onCreate(Database db, int v) async {
    return await db.execute(
        'CREATE TABLE mytodo (id INTEGER PRIMARY KEY,title TEXT,des TEXT,cat TEXT,hours INTEGER,d TEXT)');
  }

  insertdata(Mytodo ob) async {
    Database? db = await instance.database;
    await db!.insert('mytodo', ob.toMap());
  }

  Future retrive() async {
    Database? db = await instance.database;
    var mytodo = await db!.query("mytodo");
    List retrivelist = [];
    mytodo.forEach((element) {
      retrivelist.add(element);
    });
    return retrivelist;
  }

  deletevalue(int id) async {
    Database? db = await instance.database;
    await db!.delete("mytodo", where: 'id = ?', whereArgs: [id]);
  }
}
