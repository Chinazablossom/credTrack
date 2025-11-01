import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();

  static final AppDatabase instance = AppDatabase._();

  static const int _dbVersion = 1;
  static const String _dbName = 'credtrack.db';

  static const String tableUsers = 'users';
  static const String tableTickets = 'tickets';
  static const String tableTicketUpdates = 'ticket_updates';

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

        await db.execute('''
          CREATE TABLE $tableTickets (
            ticket_id TEXT PRIMARY KEY,
            user_id TEXT NOT NULL,
            category TEXT NOT NULL,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            status TEXT NOT NULL,
            created_at INTEGER NOT NULL,
            tx_ref TEXT,
            evidence_path TEXT
          );
        ''');

        await db.execute('''
          CREATE TABLE $tableTicketUpdates (
            update_id TEXT PRIMARY KEY,
            ticket_id TEXT NOT NULL,
            message TEXT NOT NULL,
            sender TEXT NOT NULL,
            timestamp INTEGER NOT NULL
          );
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS $tableTickets (
              ticket_id TEXT PRIMARY KEY,
              user_id TEXT NOT NULL,
              category TEXT NOT NULL,
              title TEXT NOT NULL,
              description TEXT NOT NULL,
              status TEXT NOT NULL,
              created_at INTEGER NOT NULL,
              FOREIGN KEY (user_id) REFERENCES $tableUsers(id) ON DELETE CASCADE ON UPDATE CASCADE
            );
          ''');

          await db.execute('''
            CREATE TABLE IF NOT EXISTS $tableTicketUpdates (
              update_id TEXT PRIMARY KEY,
              ticket_id TEXT NOT NULL,
              message TEXT NOT NULL,
              sender TEXT NOT NULL,
              timestamp INTEGER NOT NULL,
              FOREIGN KEY (ticket_id) REFERENCES $tableTickets(ticket_id) ON DELETE CASCADE ON UPDATE CASCADE
            );
          ''');
        }
      },
    );
  }
}

