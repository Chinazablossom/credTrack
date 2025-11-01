import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/helper_functions/helper_functions.dart';
import '../controller/ticket_details_controller.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({super.key, required this.controller, required this.onSend});

  final TicketDetailsController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageCtrl,
              decoration: InputDecoration(
                hintText: 'Type your message…',
                filled: true,
                fillColor: getCardTheme(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
              ),
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
            ),
          ),
          8.w,
          FloatingActionButton.small(
            onPressed: onSend,
            child: const Icon(CupertinoIcons.paperplane_fill),
          ),
        ],
      ),
    );
  }
}
