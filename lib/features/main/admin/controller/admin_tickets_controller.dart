import 'package:get/get.dart';

import '../../../../core/data/local/dao/ticket_dao.dart';
import '../../../../core/data/models/ticket.dart';
import '../../../../core/data/models/ticket_update.dart';
import '../../../main/controller/ticket_controller.dart';

class AdminTicketsController extends GetxController {
  final tickets = <TicketModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllTickets();
  }

  Future<void> loadAllTickets() async {
    isLoading.value = true;
    try {
      tickets.value = await TicketDao.instance.getAllTickets();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateStatus(String ticketId, String newStatus) async {
    await TicketDao.instance.updateTicketStatus(ticketId, newStatus);
    final index = tickets.indexWhere((t) => t.ticketId == ticketId);
    if (index != -1) {
      final t = tickets[index];
      tickets[index] = TicketModel(
        ticketId: t.ticketId,
        userId: t.userId,
        category: t.category,
        title: t.title,
        description: t.description,
        status: newStatus,
        createdAt: t.createdAt,
        transactionRef: t.transactionRef,
        evidencePath: t.evidencePath,
      );
      tickets.refresh();
    }

    // Propagate to user-facing list if present
    if (Get.isRegistered<TicketController>()) {
      try {
        final userList = Get.find<TicketController>();
        final idx = userList.tickets.indexWhere((t) => t.ticketId == ticketId);
        if (idx != -1) {
          final t = userList.tickets[idx];
          userList.tickets[idx] = TicketModel(
            ticketId: t.ticketId,
            userId: t.userId,
            category: t.category,
            title: t.title,
            description: t.description,
            status: newStatus,
            createdAt: t.createdAt,
            transactionRef: t.transactionRef,
            evidencePath: t.evidencePath,
          );
          userList.tickets.refresh();
        }
      } catch (_) {}
    }
    final now = DateTime
        .now()
        .millisecondsSinceEpoch;
    await TicketDao.instance.insertUpdate(TicketUpdateModel(
      updateId: 'admin_$now',
      ticketId: ticketId,
      message: 'Status changed to $newStatus by admin',
      sender: 'admin',
      timestamp: now,
    ));
  }
}
