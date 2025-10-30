import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/data/local/dao/ticket_dao.dart';
import '../../../../core/data/models/ticket.dart';
import '../../controller/ticket_controller.dart';

class CreateTicketController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final txRefCtrl = TextEditingController();
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final category = 'General'.obs;
  final isSaving = false.obs;
  final pickedImagePath = RxnString();

  final _picker = ImagePicker();

  Future<void> pickImage() async {
    final x = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (x != null) pickedImagePath.value = x.path;
  }

  Future<void> create() async {
    if (isSaving.value) return;
    if (!(formKey.currentState?.validate() ?? false)) return;
    isSaving.value = true;
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;
      final now = DateTime.now().millisecondsSinceEpoch;
      final ticket = TicketModel(
        ticketId: 'TXN_$now',
        userId: uid,
        category: category.value,
        title: titleCtrl.text.trim(),
        description: descCtrl.text.trim(),
        status: 'Pending',
        createdAt: now,
        transactionRef: txRefCtrl.text.trim().isEmpty
            ? null
            : txRefCtrl.text.trim(),
        evidencePath: pickedImagePath.value,
      );
      await TicketDao.instance.upsertTicket(ticket);

      if (Get.isRegistered<TicketController>()) {
        await Get.find<TicketController>().loadUserAndTickets();
      }
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    txRefCtrl.dispose();
    titleCtrl.dispose();
    descCtrl.dispose();
    super.onClose();
  }
}
