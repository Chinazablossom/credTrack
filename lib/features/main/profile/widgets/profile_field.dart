import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/helper_functions/helper_functions.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({super.key, required this.label, required this.value, this.img});

  final String label;
  final String? img;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = getTheme(context);
    final textTheme = getTextTheme(context);
    return Container(
      width: getResponsiveSpacing(
          context, small: double.infinity, medium: 500, large: 600),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: getMiniCardTheme(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
            if(img == null) Icon(Icons.person,color: theme.outline,) else  SvgPicture.asset(img!, color: theme.outline, fit: BoxFit.scaleDown,),
              4.w,
              Text(label, style: textTheme.labelSmall?.copyWith(
                  color: theme.onSurfaceVariant)),
            ],
          ),
          6.h,
          Text(value.isEmpty ? 'XXXXXXXXXXXXX' : value, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}
