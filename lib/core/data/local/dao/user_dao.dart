import 'package:sqflite/sqflite.dart';

import '../../models/user.dart';
import '../app_database.dart';

class UserDao {
  UserDao._();

  static final UserDao instance = UserDao._();

  Future<Database> get _db async => AppDatabase.instance.database;

  Future<void> upsertUser(UserModel user) async {
    final db = await _db;
    await db.insert(AppDatabase.tableUsers, {
      'id': user.userID,
      'name': user.userName,
      'email': user.userEmail,
      'credPalId': user.userCredPalId,
      'image': user.userImage,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<UserModel?> getUserById(String id) async {
    final db = await _db;
    final rows = await db.query(
      AppDatabase.tableUsers,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (rows.isEmpty) return null;
    final r = rows.first;
    return UserModel(
      userID: r['id'] as String,
      userName: r['name'] as String,
      userEmail: r['email'] as String,
      userCredPalId: r['credPalId'] as String,
      userImage: r['image'] as String,
    );
  }

  Future<void> clearAll() async {
    final db = await _db;
    await db.delete(AppDatabase.tableUsers);
  }
}
