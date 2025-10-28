
import 'package:flutter/material.dart';

extension NumExt on num {
  double get toDouble => this.toDouble();

  Spacer get s => const Spacer();

  SizedBox get h => SizedBox(height: this.toDouble());

  SizedBox get w => SizedBox(width: this.toDouble());
}
