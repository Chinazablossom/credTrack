import 'package:flutter/material.dart';

import '../../../../core/data/models/ticket_update.dart';
import '../../../../core/utils/helper_functions/helper_functions.dart';

class UpdateBubble extends StatelessWidget {
  const UpdateBubble({super.key, required this.update});

  final TicketUpdateModel update;

  @override
  Widget build(BuildContext context) {
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);
    return Align(
      alignment: update.sender == 'User' ? Alignment.centerRight : Alignment
          .centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
        decoration: BoxDecoration(
          color: update.sender == 'User' ? theme.secondaryContainer.withValues(alpha: 0.5) : theme.tertiaryContainer.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(update.message, style: textTheme.bodySmall?.copyWith(
          color: update.sender == 'User' ? isLightMode(context) ? theme.onSecondaryContainer : Colors.white : Colors.white,
        )),
      ),
    );
  }
}
