import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/data/models/ticket.dart';
import '../../../../core/utils/helper_functions/helper_functions.dart';

class DescriptionCard extends StatelessWidget {
  const DescriptionCard({super.key, required this.ticket});

  final TicketModel ticket;

  @override
  Widget build(BuildContext context) {
    final textTheme = getTextTheme(context);
    final theme = getTheme(context);
    final lastUpdated = DateFormat(
      'MMM dd, yyyy HH:mm',
    ).format(DateTime.fromMillisecondsSinceEpoch(ticket.createdAt));
    return Container(
      width: getResponsiveSpacing(
        context,
        small: double.infinity,
        medium: 600,
        large: 700,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
            Text('Issue Details', style: textTheme.labelMedium),
            8.h,
            if ((ticket.evidencePath ?? '').isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  ticket.evidencePath!,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox(),
                ),
              ),
            if ((ticket.evidencePath ?? '').isNotEmpty) 8.h,
            Text(ticket.description, style: textTheme.bodyMedium),
            8.h,
            Text(
              'Last updated: On $lastUpdated',
              style: textTheme.bodySmall?.copyWith(
                color: theme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
