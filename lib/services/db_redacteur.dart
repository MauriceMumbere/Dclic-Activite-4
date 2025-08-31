import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/redacteur.dart';

class DBHelper {
  static Database? _db;

  // Nom de la table
  static const String tableRedacteur = "redacteurs";

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "redacteurs.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableRedacteur (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT NOT NULL,
            prenom TEXT NOT NULL,
            email TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // CRUD
  static Future<int> insertRedacteur(Redacteur redacteur) async {
    final db = await database;
    return await db.insert(tableRedacteur, redacteur.toMap());
  }

  static Future<List<Redacteur>> getRedacteurs() async {
    final db = await database;
    final maps = await db.query(tableRedacteur);
    return maps.map((map) => Redacteur.fromMap(map)).toList();
  }

  static Future<int> updateRedacteur(Redacteur redacteur) async {
    final db = await database;
    return await db.update(
      tableRedacteur,
      redacteur.toMap(),
      where: "id = ?",
      whereArgs: [redacteur.id],
    );
  }

  static Future<int> deleteRedacteur(int id) async {
    final db = await database;
    return await db.delete(tableRedacteur, where: "id = ?", whereArgs: [id]);
  }
}
