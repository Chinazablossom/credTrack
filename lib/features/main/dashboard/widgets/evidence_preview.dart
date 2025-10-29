import 'dart:io';

import 'package:flutter/material.dart';

class EvidencePreview extends StatelessWidget {
  const EvidencePreview({super.key, this.path});

  final String? path;

  @override
  Widget build(BuildContext context) {
    if (path == null || path!.isEmpty) {
      return const SizedBox.shrink();
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        File(path!),
        height: 48,
        width: 48,
        fit: BoxFit.cover,
      ),
    );
  }
}
