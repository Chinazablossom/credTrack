
import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:cred_track/core/utils/helper_functions/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/data/models/ticket.dart';
import '../../../../core/utils/common/back_button.dart';
import '../controller/ticket_details_controller.dart';
import '../widgets/message_input.dart';
import '../widgets/update_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      TicketDetailsController(ticket),
      tag: ticket.ticketId,
    );
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: getCardTheme(context),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: isLightMode(context)
                        ? Colors.black.withValues(alpha: 0.16)
                        : Colors.black.withValues(alpha: 0.38),
                    blurRadius: 3,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CTBackButton(),
                      12.w,
                      Text(
                        "Chat With Support",
                        style: textTheme.titleSmall?.copyWith(
                          color: theme.inverseSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 100,
            left: 0,
            right: 0,
            bottom: 0,
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: getMiniCardTheme(context),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(22),
                      topRight: Radius.circular(22),
                    ),
                    border: Border.all(
                      color: theme.outline,
                      width: 1,
                    ) ,
                    boxShadow: [
                      BoxShadow(
                        color: isLightMode(context)
                            ? Colors.black.withValues(alpha: 0.16)
                            : Colors.black.withValues(alpha: 0.38),
                        blurRadius: 3,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          controller: controller.chatScrollCtrl,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 12,
                          ),
                          itemCount: controller.updates.length,
                          separatorBuilder: (_, __) => 1.h,
                          itemBuilder: (_, index) => UpdateBubble(
                            update: controller.updates[index],
                          ),
                        ),
                      ),
                      MessageInput(
                        controller: controller,
                        onSend: () =>
                            controller.sendMessage(sender: 'User'),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );

  }


}
