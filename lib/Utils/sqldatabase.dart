import 'package:flutter/cupertino.dart';
import 'package:puzzeled_up/Utils/todoelemnt.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class sqlDataBase {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intializeDb();
      return _db;
    } else {
      return _db;
    }
  }

  intializeDb() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, "todolist.db");
    Database mydb = await openDatabase(path, version: 2, onCreate: _onCreate);

    return mydb;
  }

  _onCreate(Database db, int version) async {
    String sql = '''
Create TABLE "todolist"(
  "id" INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT,
  "prompt" TEXT NOT NULL
) 

''';
    await db.execute(sql);
    sql = '''
Create TABLE "user"(
  "id" INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT,
  "name" TEXT NOT NULL
) 

''';
    await db.execute(sql);
  }

  readData(String sql) async {
    Database? puppetDb = await db;
    List<Map> response = await puppetDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? puppetDb = await db;
    int response = await puppetDb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? puppetDb = await db;
    int response = await puppetDb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? puppetDb = await db;
    int response = await puppetDb!.rawDelete(sql);
    return response;
  }

  // loadlist() async {
  //   final List<Map<String, dynamic>> maps =
  //       await readData("SELECT prompt FROM 'todolist'");

  //   return List.generate(maps.length, (i) {
  //     return toDoElement(
  //       prompt: maps[i]['prompt'],
  //     );
  //   });
  // }
  loadlist() async {
    final List<Map<String, dynamic>> maps =
        await readData("SELECT prompt FROM 'todolist'");
    return List.generate(maps.length, (i) {
      return toDoElement(
        prompt: maps[i]['prompt'],
      );
    });
  }

  deleteDb() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, "todolist.db");
    await deleteDatabase(path);
  }

  Future adduser(TextEditingController usernamectrl) async {
    await insertData(
        "INSERT INTO 'user' ('name') VALUES ('${usernamectrl.text.trim()}')");
  }

  Future<List<Map>> greetings() async {
    List<Map> response = await readData("SELECT * FROM user");
    return response;
  }
}
