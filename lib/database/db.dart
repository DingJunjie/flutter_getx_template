import "package:at_planning/database/db.config.dart";
import "package:at_planning/database/sql.dart";
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

class DB {
  static DB? _instance;

  DB._internal();

  static DB getInstance() {
    _instance ??= DB._internal();

    return _instance!;
  }

  Database? _database;

  Future<Database> getDatabase() async {
    if (_database == null) {
      final path = dbConfig.path;
      final version = dbConfig.version;
      final dbPath = await getDatabasesPath();
      _database = await openDatabase(join(dbPath, path),
          version: version, onCreate: _createDatabase);
    }

    return _database!;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute(SQL.initDatabase);
  }

  // Future<T> getData<T>(String table, String sql) async {}
}
