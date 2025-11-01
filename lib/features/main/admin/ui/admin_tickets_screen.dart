import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/common/back_button.dart';
import '../../../../core/utils/constants/asset_paths.dart';
import '../../../../core/utils/helper_functions/helper_functions.dart';
import '../../dashboard/widgets/status_chip.dart';
import '../../details/ui/ticket_details_screen.dart';
import '../controller/admin_tickets_controller.dart';
import 'admin_ticket_details_screen.dart';

class AdminTicketsScreen extends StatelessWidget {
  const AdminTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminTicketsController());
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
                height: 80,
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
                        "Admin Dashboard",
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
            top: 90,
            left: 0,
            right: 0,
            bottom: 0,
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.tickets.isEmpty) {
                return Center(
                  child: Text('No tickets found', style: textTheme.bodyLarge),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: controller.tickets.length,
                separatorBuilder: (_, __) => 16.h,
                itemBuilder: (_, i) {
                  final ticket = controller.tickets[i];
                  return  InkWell(
                    onTap: () =>
                        Get.to(
                              () => AdminTicketDetailsScreen(ticket: ticket),
                          transition: Transition.rightToLeft,
                          duration: 300.milliseconds,
                        ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: getCardTheme(context),
                        borderRadius: BorderRadius.all(Radius.circular(16),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isLightMode(context)
                                ? Colors.black.withValues(alpha: 0.16)
                                : Colors.black.withValues(alpha: 0.38),
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      width: getResponsiveSpacing(context,small: double.infinity,medium: 600,large: 700),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12,left: 12,right: 12,bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(CupertinoIcons.tickets,color: theme.outline ),
                                      4.w,
                                      Text(ticket.title, style: textTheme.labelSmall),
                                    ],
                                  ),
                                  8.h,
                                  Row(
                                    children: [
                                      SvgPicture.asset(idSvg, color: theme.outline, fit: BoxFit.scaleDown,),
                                      4.w,
                                      Text('User ID: ${ticket.userId}',style: textTheme.bodySmall,),
                                    ],
                                  ),
                                  6.h,
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Category:  ${ticket.category}",
                                            style: textTheme.bodySmall?.copyWith(
                                              color: theme.onSurfaceVariant,
                                            ),
                                          ),

                                          4.h,
                                          Row(
                                            children: [
                                              SvgPicture.asset(clockSvg, color: theme.outline, fit: BoxFit.scaleDown,height: 14,width: 16,),
                                              4.w,
                                              Text(
                                                DateFormat('On MMM dd, yyyy - HH:mm: a').format(
                                                  DateTime.fromMillisecondsSinceEpoch(
                                                    ticket.createdAt,
                                                  ).toLocal(),
                                                ),
                                                style: textTheme.bodySmall?.copyWith(
                                                  color: theme.onSurfaceVariant,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      StatusChip(status: ticket.status)
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );

                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
