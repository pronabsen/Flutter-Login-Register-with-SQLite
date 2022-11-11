import 'dart:io';

import 'package:library_management/models/user.dart';
import 'package:library_management/utils/Constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static Database ? _database;

  static const _databaseName = "LibraryManagement";
  static const _databaseVersion = 1;

  //TABLE NAME
  static String tblUser = 'users';
  //FIELD
  static String ID = 'id';
  static String NAME = 'name';
  static String EMAIL = 'email';
  static String PASSWORD = 'password';

  String registerQuery = "CREATE TABLE $tblUser ( "
      "$ID INTEGER PRIMARY KEY,"
      "$NAME TEXT NOT NULL, "
      "$EMAIL TEXT NOT NULL,"
      "$PASSWORD TEXT NOT NULL )";


  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();


  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(registerQuery);
  }

  //INSERT
  Future<int?> registerUsers(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    var findUser = await db!.query(tblUser, where: "email = ?", whereArgs: [row['email']]);
    return findUser.isEmpty ? await db.insert(tblUser, row) : null;
  }
  //Login
  Future<Map<String, Object?>?> loginUsers(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    String email = row['email']; String pass = row['password'];
    var findUser = await db!.query(tblUser, where: "email = '$email' and password = '$pass'");
    print(findUser[0]);

    return findUser.isNotEmpty ? findUser[0] : null;
  }

  //getAllUsers
  Future<List<UserModel>> getAllUsers() async {
    Database? db = await instance.database;
   // return
    var res = await db?.query(tblUser);
    List<UserModel> userList = res!.isNotEmpty ? res.map((c) => UserModel.fromMap(c)).toList() : [];
    return userList;
  }

  getAllUserss() async {
    Database? db = await instance.database;
    var res = await db?.query(tblUser);
    List<UserModel> userList = res!.isNotEmpty ? res.map((c) => UserModel.fromMap(c)).toList() : [];
    return userList;
  }
}
