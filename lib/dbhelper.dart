import 'dart:developer';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo2/user.dart';

class DbHelper {
  Database? _db;

  String DB_Name = 'test.db';
  String Table_User = 'user';
  int Version = 1;

  String C_UserID = 'user_id';
  String C_UserName = 'user_name';
  String C_Email = 'email';
  String C_Password = 'password';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserID INTEGER AUTO_INCREMENT PRIMARY KEY,"
        " $C_UserName TEXT,"
        " $C_Email TEXT,"
        " $C_Password TEXT"
        ")");
  }

  Future<int?> insert(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient?.insert(Table_User, user.toMap());
    return res;
  }
  //
  // Future<List<Map<String, Object?>>?> getAllUser() async {
  //   var dbClient = await db;
  //   var res = await dbClient
  //       ?.query(Table_User, where: C_UserName, whereArgs: [C_UserName]);
  //   return res;
  // }

  Future<List<UserModel>> getAllUser() async {
    var dbClient = await db;
    var res = await dbClient?.query(Table_User, orderBy: C_UserName);
    List<UserModel> userList =
        res!.isNotEmpty ? res.map((c) => UserModel.fromMap(c)).toList() : [];
    log("userList ==> $userList");
    return userList;
  }

  Future<int?> updateUser(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient?.update(Table_User, user.toMap(),
        where: '$C_UserID = ?', whereArgs: [user.user_id]);
    return res;
  }

  Future<int?> deleteUser(String userId) async {
    var dbClient = await db;
    var res = await dbClient
        ?.delete(Table_User, where: '$C_UserID = ?', whereArgs: [userId]);
    return res;
  }
}
