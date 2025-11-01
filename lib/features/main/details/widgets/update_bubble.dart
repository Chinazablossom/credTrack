import 'package:flutter/material.dart';

import '../../../../core/data/models/ticket_update.dart';
import '../../../../core/utils/helper_functions/helper_functions.dart';

class UpdateBubble extends StatelessWidget {
  const UpdateBubble(
      {super.key, required this.update, required this.currentSender});

  final TicketUpdateModel update;
  final String currentSender;

  @override
  Widget build(BuildContext context) {
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);
    final bool isMine = update.sender.toLowerCase() == currentSender.toLowerCase();
    final Color bubbleColor = isMine
        ? theme.tertiaryContainer.withValues(alpha: 0.6)
        : theme.secondaryContainer.withValues(alpha: 0.5);
    final Color textColor = isMine
        ? Colors.white
        : (isLightMode(context) ? theme.onSecondaryContainer : Colors.white);

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          update.message,
          style: textTheme.bodySmall?.copyWith(color: textColor),
        ),
      ),
    );
  }
}
