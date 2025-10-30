import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/data/local/dao/ticket_dao.dart';
import '../../../core/data/local/dao/user_dao.dart';
import '../../../core/data/models/ticket.dart';
import '../../../core/data/models/ticket_update.dart';
import '../../../core/data/models/user.dart';

class TicketController extends GetxController {
  final tickets = <TicketModel>[].obs;
  final isLoading = false.obs;
  final currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadUserAndTickets();
  }

  Future<void> loadUserAndTickets() async {
    isLoading.value = true;
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        currentUser.value = await UserDao.instance.getUserById(uid);
        tickets.value = await TicketDao.instance.getTicketsForUser(uid);
      } else {
        tickets.clear();
        currentUser.value = null;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createTicket({
    required String category,
    required String title,
    required String description,
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    final ticket = TicketModel(
      ticketId: 't_id_$now',
      userId: uid,
      category: category,
      title: title,
      description: description,
      status: 'Pending',
      createdAt: now,
    );

    await TicketDao.instance.upsertTicket(ticket);
    await loadUserAndTickets();
  }

  Future<void> addUpdate({
    required String ticketId,
    required String message,
    required String sender,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final update = TicketUpdateModel(
      updateId: 'u_id_$now',
      ticketId: ticketId,
      message: message,
      sender: sender,
      timestamp: now,
    );
    await TicketDao.instance.insertUpdate(update);
  }

}
