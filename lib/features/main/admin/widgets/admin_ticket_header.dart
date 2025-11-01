import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/data/models/ticket.dart';
import '../../../../core/utils/constants/asset_paths.dart';
import '../../../../core/utils/helper_functions/helper_functions.dart';
import '../../dashboard/widgets/status_chip.dart';

class AdminTicketHeader extends StatelessWidget {
  const AdminTicketHeader({
    super.key,
    required this.theme,
    required this.ticket,
    required this.textTheme,
  });

  final ColorScheme theme;
  final TicketModel ticket;
  final TextTheme textTheme;

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
                Icon(CupertinoIcons.tickets, color: theme.outline, size: 18),
                4.w,
                Text(ticket.title, style: textTheme.labelLarge),
              ],
            ),
            8.h,
            Row(
              children: [
                SvgPicture.asset(
                  ticketIdSvg,
                  color: theme.outline,
                  fit: BoxFit.scaleDown,
                  height: 20,
                ),
                4.w,
                Text(
                  "Ticked ID: ${ticket.ticketId}",
                  style: textTheme.bodyMedium?.copyWith(
                    color: theme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            8.h,

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category: ${ticket.category}",
                      style: textTheme.bodySmall?.copyWith(
                        color: theme.outline,
                      ),
                    ),
                    8.h,
                    Row(
                      children: [
                        SvgPicture.asset(
                          clockSvg,
                          color: theme.outline,
                          fit: BoxFit.scaleDown,
                          height: 14,
                          width: 16,
                        ),
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
                StatusChip(status: ticket.status),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
