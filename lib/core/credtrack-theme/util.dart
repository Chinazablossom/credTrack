import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
  GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    displayLarge: displayTextTheme.displayLarge,
    displayMedium: displayTextTheme.displayMedium,
    displaySmall: displayTextTheme.displaySmall,
    headlineLarge: displayTextTheme.headlineLarge,
    headlineMedium: displayTextTheme.headlineMedium,
    headlineSmall: displayTextTheme.headlineSmall,
    titleLarge: displayTextTheme.titleLarge,
    titleMedium: displayTextTheme.titleMedium,
    titleSmall: displayTextTheme.titleSmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
  );
  return textTheme;
}
