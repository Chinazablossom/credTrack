import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/helper_functions/helper_functions.dart';

class AuthCard extends StatelessWidget {
  const AuthCard(
      {super.key, required this.title, required this.subtitle, required this.child});

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = getTextTheme(context);
    final theme = getTheme(context);

    return Container(
      decoration:BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(24)),
      color: getCardTheme(context),
        boxShadow: [
          BoxShadow(
            color: isLightMode(context)
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.white10.withValues(alpha: 0.08),
            blurRadius: 40,
            offset: Offset(0, isLightMode(context) ? 8 : 0),
          ),
        ],
      ),

      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(12, 20, 12, 24),
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              8.h,
              Text(title, style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
              6.h,
              Text(subtitle, style: textTheme.bodyMedium?.copyWith(color: theme.onSurfaceVariant)),
              20.h,
              child,
            ],
          ),
        ),
    );
  }
}
