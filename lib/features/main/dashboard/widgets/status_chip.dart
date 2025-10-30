import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    Color bg;
    switch (status) {
      case 'Resolved':
        bg = Colors.green;
        break;
      case 'In Progress':
        bg = Colors.blue;
        break;
      default:
        bg = Color(0xffff9307);
    }
    return Chip(
      label: Text(status, style: const TextStyle(color: Colors.white)),
      backgroundColor: bg,
    );
  }
}
