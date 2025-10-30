import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:cred_track/core/utils/helper_functions/helper_functions.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../core/data/local/dao/ticket_dao.dart';
import '../../../../core/data/models/ticket.dart';
import '../../../../core/data/models/ticket_update.dart';
import '../../../../core/utils/common/snack_bars.dart';
import '../../controller/ticket_controller.dart';

class TicketDetailsController extends GetxController {
  TicketDetailsController(TicketModel initialTicket) {
    ticket = initialTicket.obs;
  }

  late final Rx<TicketModel> ticket;

  final TextEditingController messageCtrl = TextEditingController();
  final ScrollController chatScrollCtrl = ScrollController();
  final RxList<TicketUpdateModel> updates = <TicketUpdateModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUpdates();

    ever<List<TicketUpdateModel>>(updates, (_) => _scrollToBottom());
  }

  Future<void> loadUpdates() async {
    isLoading.value = true;
    try {
      updates.value = await TicketDao.instance.getUpdatesForTicket(
        ticket.value.ticketId,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage({String sender = 'user'}) async {
    final text = messageCtrl.text.trim();
    if (text.isEmpty) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    final update = TicketUpdateModel(
      updateId: 'u_$now',
      ticketId: ticket.value.ticketId,
      message: text,
      sender: sender,
      timestamp: now,
    );
    await TicketDao.instance.insertUpdate(update);
    messageCtrl.clear();
    await loadUpdates();
  }

  void _scrollToBottom() {
    if (!chatScrollCtrl.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        chatScrollCtrl.animateTo(
          chatScrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } catch (_) {}
    });
  }

  Future<void> editTicket() async {
    final titleCtrl = TextEditingController(text: ticket.value.title);
    final descCtrl = TextEditingController(text: ticket.value.description);
    final categoryCtrl = TextEditingController(text: ticket.value.category);
    final theme = getTheme(Get.context!);
    final textTheme = getTextTheme(Get.context!);
    String statusValue = ticket.value.status;

    await Get.bottomSheet(
      enableDrag: false,
      SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          decoration: BoxDecoration(
            color: getCardTheme(Get.context!),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text('Edit Ticket', style: textTheme.titleMedium),
                ),
                8.h,
                const Divider(height: 1),
                8.h,
                16.h,
                TextFormField(
                  controller: titleCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                14.h,

                DropdownButtonFormField<String>(
                  value: categoryCtrl.text,
                  style: textTheme.bodyMedium,
                  borderRadius: BorderRadius.circular(12),
                  items: const [
                    DropdownMenuItem(
                      value: 'General',
                      child: Text('General'),
                    ),
                    DropdownMenuItem(
                      value: 'Payments',
                      child: Text('Payments'),
                    ),
                    DropdownMenuItem(
                      value: 'Account',
                      child: Text('Account'),
                    ),
                    DropdownMenuItem(value: 'Wallet', child: Text('Wallet')),
                    DropdownMenuItem(value: 'Bills', child: Text('Bills')),
                    DropdownMenuItem(value: 'Card', child: Text('Card')),
                  ],
                  onChanged: (v) => categoryCtrl.text = v!,
                ),

                14.h,
                TextFormField(
                  controller: descCtrl,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),

                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final updated = TicketModel(
                      ticketId: ticket.value.ticketId,
                      userId: ticket.value.userId,
                      category: categoryCtrl.text.trim().isEmpty
                          ? ticket.value.category
                          : categoryCtrl.text.trim(),
                      title: titleCtrl.text.trim().isEmpty
                          ? ticket.value.title
                          : titleCtrl.text.trim(),
                      description: descCtrl.text.trim().isEmpty
                          ? ticket.value.description
                          : descCtrl.text.trim(),
                      status: statusValue,
                      createdAt: ticket.value.createdAt,
                      transactionRef: ticket.value.transactionRef,
                      evidencePath: ticket.value.evidencePath,
                    );
                    await TicketDao.instance.upsertTicket(updated);
                    ticket.value = updated;
                    ticket.refresh();

                    try {
                      final listCtrl = Get.find<TicketController>();
                      final index = listCtrl.tickets.indexWhere(
                        (t) => t.ticketId == updated.ticketId,
                      );
                      if (index != -1) {
                        listCtrl.tickets[index] = updated;
                        listCtrl.tickets.refresh();
                      } else {
                        await listCtrl.loadUserAndTickets();
                      }
                    } catch (_) {

                    }

                    final now = DateTime
                        .now()
                        .millisecondsSinceEpoch;
                    await TicketDao.instance.insertUpdate(
                      TicketUpdateModel(
                        updateId: 'sys_$now',
                        ticketId: ticket.value.ticketId,
                        message: 'Ticket updated by user',
                        sender: 'system',
                        timestamp: now,
                      ),
                    );

                    await loadUpdates();
                    Get.back();
                    SnackBars.displaySnackBar(
                        title: 'Saved',
                        message: 'Ticket updated successfully',
                      isSuccess: true

                    );
                  },
                  child: const Text('Save changes'),
                ),
              ],
            ),
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  void onClose() {
    messageCtrl.dispose();
    chatScrollCtrl.dispose();
    super.onClose();
  }
}
