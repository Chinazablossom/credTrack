import 'package:cred_track/core/utils/constants/asset_paths.dart';
import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:cred_track/features/main/details/ui/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/data/models/ticket.dart';
import '../../../../core/utils/common/back_button.dart';
import '../../../../core/utils/helper_functions/helper_functions.dart';
import '../controller/ticket_details_controller.dart';
import '../widgets/description_card.dart';
import '../widgets/message_input.dart';
import '../widgets/ticket_header.dart';
import '../widgets/update_bubble.dart';

class TicketDetailsScreen extends StatelessWidget {
  const TicketDetailsScreen({super.key, required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);
    final controller = Get.put(
      TicketDetailsController(ticket),
      tag: ticket.ticketId,
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                        "Ticket Details",
                        style: textTheme.titleSmall?.copyWith(
                          color: theme.inverseSurface,
                        ),
                      ),

                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.share_rounded),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.editTicket();
                        },
                        icon: Icon(Icons.edit),
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
            child: Column(
              children: [
                // Header
                TicketHeaderCard(ticket: ticket),

                DescriptionCard(ticket: ticket),
                12.h,

                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
                  child: FilledButton.icon(
                    onPressed: () => Get.to(
                      () => ChatScreen(ticket: ticket),
                      transition: Transition.rightToLeft,
                      duration: 300.milliseconds,
                    ),
                    style: FilledButton.styleFrom(
                      minimumSize: Size(getResponsiveSpacing(context,small: double.infinity,medium: 500,large: 600), 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: SvgPicture.asset(supportSvg,fit: BoxFit.scaleDown,color: theme.onPrimary,),

                    label: Text("Talk to Support"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
