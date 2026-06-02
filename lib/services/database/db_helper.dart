import 'package:doctor_appointment/models/appointment_model.dart';
import 'package:doctor_appointment/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  DBHelper._init();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('doctor_appointment.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await createAppointmentTable(db);
      },
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      );
''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS appointments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId INTEGER NOT NULL,
      doctorId INTEGER NOT NULL,
      date TEXT NOT NULL,
      time TEXT NOT NULL,
      FOREIGN KEY(userId) REFERENCES users(id) ON DELETE CASCADE
    )
  ''');
  }

  Future<int> insertUser(UserModel user) async {
    final db = await instance.database;
    return db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<UserModel?> loginUser(String email, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<UserModel?> getUser(int userId) async {
    final db = await instance.database;
    final user = await db.query('users', where: 'id = ?', whereArgs: [userId]);
    if (user.isNotEmpty) {
      return UserModel.fromMap(user.first);
    } else {
      return null;
    }
  }

  Future<void> createAppointmentTable(Database db) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS appointments (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId INTEGER NOT NULL,
      doctorId INTEGER NOT NULL,
      date TEXT NOT NULL,
      time TEXT NOT NULL,
      FOREIGN KEY(userId) REFERENCES users(id) ON DELETE CASCADE
    )
  ''');
  }

  Future<int> insertAppointment(AppointmentModel appointment) async {
    final db = await instance.database;
    return await db.insert(
      'appointments',
      appointment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<List<AppointmentModel>> getAppointmentsByUser(int userId) async {
    final db = await instance.database;

    final result = await db.query(
      'appointments',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'date DESC',
    );

    return result.map((e) => AppointmentModel.fromMap(e)).toList();
  }

  Future<int> deleteAppointment(int id) async {
    final db = await instance.database;
    return await db.delete('appointments', where: 'id = ?', whereArgs: [id]);
  }
}
