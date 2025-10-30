import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/material.dart';

import '../../../../core/credtrack-theme/theme.dart';
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
      width: getResponsiveSpacing(context,small: double.infinity,medium: 600,large: 700),
      decoration:BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(24)),
      color: isLightMode(context)
          ? MaterialTheme.lightScheme().surfaceContainerLowest
          : MaterialTheme.darkScheme().surfaceContainerHigh,
        boxShadow: [
          BoxShadow(
            color: isLightMode(context)
                ? Colors.black.withValues(alpha: 0.16)
                : Colors.black.withValues(alpha: 0.38),
            blurRadius: 20,
            offset: Offset(0, isLightMode(context) ? 8 : 0),
          ),
        ],
      ),

      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
            getResponsiveSpacing(context,small: 12,medium: 30,large: 50), 20, getResponsiveSpacing(context,small: 12,medium: 30,large: 50 ), 24),
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
