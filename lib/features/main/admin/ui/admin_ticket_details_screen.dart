import 'dart:io';

import 'package:cred_track/core/utils/constants/asset_paths.dart';
import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:cred_track/features/main/dashboard/widgets/status_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/common/back_button.dart';
import '../../../../core/utils/helper_functions/helper_functions.dart';
import '../../../../core/data/models/ticket.dart';
import '../../details/ui/chat_screen.dart';
import '../../details/widgets/description_card.dart';
import '../controller/admin_tickets_controller.dart';
import '../widgets/admin_ticket_details.dart';
import '../widgets/admin_ticket_header.dart';

class AdminTicketDetailsScreen extends StatelessWidget {
  const AdminTicketDetailsScreen({super.key, required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminTicketsController>();
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);
    final status = RxString(ticket.status);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CTBackButton(),
                  8.w,
                  Text(
                    "Ticket(Admin)",
                    style: textTheme.titleSmall?.copyWith(
                      color: theme.inverseSurface,
                    ),
                  ),
                  Spacer(),
                  FilledButton.icon(
                    onPressed: () => Get.to(
                      () => ChatScreen(ticket: ticket, senderLabel: 'Admin'),
                      transition: Transition.rightToLeft,
                      duration: 300.milliseconds,
                    ),
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    icon: SvgPicture.asset(supportSvg, color: theme.onPrimary),
                    label: const Text('Open Chat'),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Column(
              children: [
                AdminTicketHeader(
                  theme: theme,
                  ticket: ticket,
                  textTheme: textTheme,
                ),

                AdminTicketDetails(theme: theme, textTheme: textTheme, ticket: ticket, status: status, controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


