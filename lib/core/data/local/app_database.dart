import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const int _dbVersion = 1;
  static const String _dbName = 'credtrack.db';

  static const String tableUsers = 'users';

  Database? _db;


  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _init();
    return _db!;
  }

  Future<Database> _init() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {

        await db.execute('''
          CREATE TABLE $tableUsers (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            credPalId TEXT NOT NULL,
            image TEXT NOT NULL
          );
        ''');
      },
    );
  }
}

