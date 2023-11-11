import 'package:myjobapp/Classes/tintuc_class.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDataBase {
  late Database db;
  Future initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    await deleteDatabase(path);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS Tintuc (id INTEGER PRIMARY KEY, link TEXT, image TEXT, title TEXT, author TEXT)');
    });
  }

  Future insertNews(TinTucClass tintuc) async {
    return db.insert('Tintuc', TinTucClass.toJson(tintuc),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> queryNew() {
    return db.query('Tintuc');
  }
}
