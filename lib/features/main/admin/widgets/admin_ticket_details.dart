import 'dart:io';

import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../../core/data/models/ticket.dart';
import '../../../../core/utils/common/snack_bars.dart';
import '../../../../core/utils/constants/asset_paths.dart';
import '../../../../core/utils/helper_functions/helper_functions.dart';
import '../controller/admin_tickets_controller.dart';

class AdminTicketDetails extends StatelessWidget {
  const AdminTicketDetails({
    super.key,
    required this.theme,
    required this.textTheme,
    required this.ticket,
    required this.status,
    required this.controller,
  });

  final ColorScheme theme;
  final TextTheme textTheme;
  final TicketModel ticket;
  final RxString status;
  final AdminTicketsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getResponsiveSpacing(
        context,
        small: double.infinity,
        medium: 600,
        large: 700,
      ),
      margin: const EdgeInsets.fromLTRB(8, 12, 8, 8),
      decoration: BoxDecoration(
        color: getCardTheme(context),
        borderRadius: BorderRadius.all(Radius.circular(16)),
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  complaintSvg,
                  color: theme.outline,
                  fit: BoxFit.scaleDown,
                ),
                4.w,
                Text('Issue Details', style: textTheme.labelMedium),
              ],
            ),
            16.h,
            Text(ticket.description, style: textTheme.bodyMedium),
            16.h,
            if ((ticket.evidencePath ?? '').trim().isNotEmpty)
              Builder(
                builder: (_) {
                  final path = ticket.evidencePath!.trim();
                  final isNetwork =
                      path.startsWith('http://') ||
                      path.startsWith('https://');
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: isNetwork
                        ? Image.network(
                            path,
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const SizedBox(),
                          )
                        : Image.file(
                            File(path),
                            height: 140,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const SizedBox(),
                          ),
                  );
                },
              ),
            if ((ticket.evidencePath ?? '').trim().isNotEmpty) 8.h,
            20.h,

            Row(
              children: [
                Text('Status:', style: textTheme.bodyLarge),
                12.w,
                Obx(
                  () => DropdownButton<String>(
                    value: status.value,
                    style: textTheme.bodyMedium,
                    borderRadius: BorderRadius.all(Radius.circular(12)) ,
                    items: const [
                      DropdownMenuItem(
                        value: 'Pending',
                        child: Text('Pending'),
                      ),
                      DropdownMenuItem(
                        value: 'In Progress',
                        child: Text('In Progress'),
                      ),
                      DropdownMenuItem(
                        value: 'Resolved',
                        child: Text('Resolved'),
                      ),
                      DropdownMenuItem(
                        value: 'Closed',
                        child: Text('Closed'),
                      ),
                    ],
                    onChanged: (v) {
                      if (v != null) status.value = v;
                    },
                  ),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () async {
                    await controller.updateStatus(
                      ticket.ticketId,
                      status.value,
                    );
                    SnackBars.displaySnackBar(title: 'Saved', message: 'Status Updated',isSuccess: true);
                    },
                  style: FilledButton.styleFrom(
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),


          ],
        ),
      ),
    );
  }
}
