import 'package:evaluacion/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseUser {
  static final DatabaseUser instance = DatabaseUser._init();

  static Database? _database;

  DatabaseUser._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idtype = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    await db.execute('''
       CREATE TABLE $tableUsers (
        ${UserFields.id} $idtype,
        ${UserFields.name} $textType,
        ${UserFields.password} $textType
       )''');
  }

  Future<UsersModel> createObject(UsersModel user) async {
    final db = await instance.database;

    final id = await db.insert(
      tableUsers,
      {
        UserFields.name : user.name,
        UserFields.password :  user.password
      }

    );

    return user.copy(id: id);
  }


  Future<UsersModel> readUser(String name, String password) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUsers,
      columns: UserFields.values,
      where: '${UserFields.name} = ? AND ${UserFields.password} = ?',
      whereArgs: [name, password],
    );

    if (maps.isNotEmpty) {
      return UsersModel.fromJson(maps.first);
    } else {
      throw Exception('User not found');
    }
  }


}