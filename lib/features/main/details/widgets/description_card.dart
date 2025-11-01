import 'dart:io';

import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/data/models/ticket.dart';
import '../../../../core/utils/constants/asset_paths.dart';
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
            Row(
              children: [
                SvgPicture.asset(complaintSvg, color: theme.outline, fit: BoxFit.scaleDown,),
                4.w,
                Text('Issue Details', style: textTheme.labelMedium),
              ],
            ),
            12.h,
            Text(ticket.description, style: textTheme.bodyMedium),
            16.h,
            if ((ticket.evidencePath ?? '')
                .trim()
                .isNotEmpty)
              Builder(builder: (_) {
                final path = ticket.evidencePath!.trim();
                final isNetwork = path.startsWith('http://') ||
                    path.startsWith('https://');
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: isNetwork
                      ? Image.network(
                    path,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  )
                      : Image.file(
                    File(path),
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox(),
                  ),
                );
              }),
            if ((ticket.evidencePath ?? '')
                .trim()
                .isNotEmpty) 8.h,
            12.h,
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
