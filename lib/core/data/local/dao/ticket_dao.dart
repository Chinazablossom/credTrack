import 'package:sqflite/sqflite.dart';

import '../../models/ticket.dart';
import '../../models/ticket_update.dart';
import '../app_database.dart';

class TicketDao {
  TicketDao._();

  static final TicketDao instance = TicketDao._();

  Future<Database> get _db async => AppDatabase.instance.database;

  Future<List<TicketModel>> getTicketsForUser(String userId) async {
    final db = await _db;
    final rows = await db.query(
      AppDatabase.tableTickets,
      where: 'user_id = ? ',
      whereArgs: [userId],
      orderBy: 'created_at DESC',
    );
    return rows.map((m) => TicketModel.fromMap(m)).toList();
  }

  Future<void> updateTicketStatus(String ticketId, String status) async {
    final db = await _db;
    await db.update(AppDatabase.tableTickets, {'status': status},
        where: 'ticket_id = ?', whereArgs: [ticketId]);
  }

  Future<void> deleteTicket(String ticketId) async {
    final db = await _db;
    await db.delete(AppDatabase.tableTickets,
        where: 'ticket_id = ?', whereArgs: [ticketId]);
  }

  // Updates
  Future<void> insertUpdate(TicketUpdateModel update) async {
    final db = await _db;
    await db.insert(AppDatabase.tableTicketUpdates, update.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> upsertTicket(TicketModel ticket) async {
    final db = await _db;

    final map = {
      'ticket_id': ticket.ticketId,
      'user_id': ticket.userId,
      'category': ticket.category,
      'title': ticket.title,
      'description': ticket.description,
      'status': ticket.status,
      'created_at': ticket.createdAt,
      'tx_ref': ticket.transactionRef,
      'evidence_path': ticket.evidencePath,
    };

    await db.insert(AppDatabase.tableTickets, map,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TicketUpdateModel>> getUpdatesForTicket(String ticketId) async {
    final db = await _db;
    final rows = await db.query(AppDatabase.tableTicketUpdates,
        where: 'ticket_id = ?', whereArgs: [ticketId], orderBy: 'timestamp');
    return rows.map((m) => TicketUpdateModel.fromMap(m)).toList();
  }

  Future<List<TicketModel>> getAllTickets() async {
    final db = await _db;
    final rows = await db.query(
      AppDatabase.tableTickets,
      orderBy: 'created_at DESC',
    );
    return rows.map((m) => TicketModel.fromMap(m)).toList();
  }
}
