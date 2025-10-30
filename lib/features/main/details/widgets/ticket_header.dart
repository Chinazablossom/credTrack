import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/data/models/ticket.dart';
import '../../../../core/utils/helper_functions/helper_functions.dart';
import '../../dashboard/widgets/status_chip.dart';

class TicketHeaderCard extends StatelessWidget {
  const TicketHeaderCard({super.key, required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);

    return Container(
      width: getResponsiveSpacing(context,small: double.infinity,medium: 600,large: 700),
      margin: const EdgeInsets.fromLTRB(8, 12, 8, 8),
      decoration: BoxDecoration(
        color: getCardTheme(context),
        borderRadius: BorderRadius.all(Radius.circular(12)),
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ticket ID: ${ticket.ticketId.substring(0, 8)}',
                          style: textTheme.bodyMedium?.copyWith(
                              color: theme.onSurfaceVariant)),
                      12.h,
                      Text(ticket.title, style: textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                StatusChip(status: ticket.status),
              ],
            ),
            12.h,
            Row(
              children: [
                txtMapper(textTheme, 'Category ', ticket.category),
                txtMapper(textTheme, 'Ref', ticket.transactionRef ?? '——'),
              ],
            ),
            12.h,
            Text('Created: ${DateFormat('On MMM dd, yyyy HH:mm a').format(
                DateTime.fromMillisecondsSinceEpoch(ticket.createdAt))}',
                style: textTheme.bodySmall?.copyWith(
                    color: theme.onSurfaceVariant)),
            12.h,
          ],
        ),
      ),
    );
  }

  Widget txtMapper(TextTheme t, String k, String v) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$k: ', style: t.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
          Flexible(child: Text(v, style: t.bodySmall)),
        ],
      ),
    );
  }
}
