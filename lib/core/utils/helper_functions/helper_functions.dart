import 'dart:io';
import 'dart:math';
import 'package:cred_track/core/utils/constants/asset_paths.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

import '../../credtrack-theme/theme.dart';
import '../../credtrack-theme/util.dart';


///   FUNCTIONS
extension RangeCheck on num {
  bool inRange(num start, num end) => this >= start && this <= end;
}

bool isLightMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.light;
}

ColorScheme getTheme(BuildContext context) {
  return isLightMode(context)
      ? MaterialTheme.lightScheme()
      : MaterialTheme.darkScheme();
}

Color getCardTheme(BuildContext context) {
  return isLightMode(context)
      ? MaterialTheme.lightScheme().surfaceContainerLowest
      : MaterialTheme.darkScheme().surfaceContainerLow;
}

String getBg(BuildContext context) {
  return isLightMode(context) ? credTrackBgSvg : credTrackBgDarkSvg;
}

Color getProfileTheme(BuildContext context) {
  return isLightMode(context)
      ? Color(0xffF5F5FA)
      : MaterialTheme.darkScheme().surfaceContainer;
}

Color getMiniCardTheme(BuildContext context) {
  return isLightMode(context) ? const Color(0xFFE2E2E7) : getTheme(context).primary.withValues(alpha: 0.5);
}

Color getTextFieldTheme(BuildContext context) {
  return isLightMode(context) ? const Color(0x80f5f5fa) : Color(0x42f5f5fa);
}

Color getSheetBgTheme(BuildContext context) {
  return isLightMode(context) ? Colors.black.withOpacity(0.1) : Colors.white.withOpacity(0.1);
}

TextTheme getTextTheme(BuildContext context) {
  TextTheme textTheme = createTextTheme(context, "Capriola", "Capriola");
  return MaterialTheme(textTheme).textTheme;
}

bool isSmallScreen(BuildContext context) {
  return MediaQuery.of(context).size.width.inRange(300, 600);
}

/// Screen dimension helpers
class ScreenDimensions {
  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static Size getSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getAspectRatio(BuildContext context) {
    final size = getSize(context);
    return size.width / size.height;
  }

  static double getDiagonal(BuildContext context) {
    final size = getSize(context);
    return sqrt(size.width * size.width + size.height * size.height);
  }

  static double getArea(BuildContext context) {
    final size = getSize(context);
    return size.width * size.height;
  }

  static Orientation getOrientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  static bool isLandscape(BuildContext context) {
    return getOrientation(context) == Orientation.landscape;
  }

  static bool isPortrait(BuildContext context) {
    return getOrientation(context) == Orientation.portrait;
  }

  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  static EdgeInsets getViewInsets(BuildContext context) {
    return MediaQuery.of(context).viewInsets;
  }

  static double getKeyboardHeight(BuildContext context) {
    return getViewInsets(context).bottom;
  }

  static bool isKeyboardVisible(BuildContext context) {
    return getKeyboardHeight(context) > 0;
  }

  static double getAvailableHeight(BuildContext context) {
    return getHeight(context) - getKeyboardHeight(context);
  }

  static double getAvailableWidth(BuildContext context) {
    return getWidth(context);
  }

  static double getPixelDensity(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static Brightness getBrightness(BuildContext context) {
    return MediaQuery.of(context).platformBrightness;
  }

  static bool isDarkMode(BuildContext context) {
    return getBrightness(context) == Brightness.dark;
  }

  static Map<String, dynamic> getScreenInfo(BuildContext context) {
    final size = getSize(context);
    final padding = getSafeAreaPadding(context);
    final viewInsets = getViewInsets(context);

    return {
      'width': size.width,
      'height': size.height,
      'aspectRatio': getAspectRatio(context),
      'diagonal': getDiagonal(context),
      'area': getArea(context),
      'orientation': getOrientation(context).toString(),
      'isLandscape': isLandscape(context),
      'isPortrait': isPortrait(context),
      'pixelDensity': getPixelDensity(context),
      'brightness': getBrightness(context).toString(),
      'isDarkMode': isDarkMode(context),
      'safeAreaTop': padding.top,
      'safeAreaBottom': padding.bottom,
      'safeAreaLeft': padding.left,
      'safeAreaRight': padding.right,
      'keyboardHeight': getKeyboardHeight(context),
      'isKeyboardVisible': isKeyboardVisible(context),
      'availableHeight': getAvailableHeight(context),
      'availableWidth': getAvailableWidth(context),
    };
  }

  static double getResponsiveSpacing(
    BuildContext context, {
    double small = 8,
    double medium = 12,
    double large = 16,
  }) {
    final width = getWidth(context);
    if (width < 600) return small;
    if (width < 900) return medium;
    return large;
  }

  static double getHeightMultiplier(
    BuildContext context, {
    double landscape = 0.02,
    double portrait = 0.05,
  }) {
    return isLandscape(context) ? landscape : portrait;
  }

  static double getWidthMultiplier(
    BuildContext context, {
    double small = 0.8,
    double medium = 0.9,
    double large = 1.0,
  }) {
    final width = getWidth(context);
    if (width < 600) return small;
    if (width < 900) return medium;
    return large;
  }

  static Widget createResponsiveContainer({
    required BuildContext context,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? height,
    double? width,
    Color? color,
    BorderRadius? borderRadius,
  }) {
    return Container(
      padding: padding ?? EdgeInsets.all(getResponsiveSpacing(context)),
      margin: margin,
      height: height,
      width: width,
      color: color,
      decoration: borderRadius != null
          ? BoxDecoration(borderRadius: borderRadius)
          : null,
      child: child,
    );
  }

  static Widget createResponsiveSpacing({
    required BuildContext context,
    bool isVertical = true,
    double small = 8,
    double medium = 12,
    double large = 16,
  }) {
    final spacing = getResponsiveSpacing(
      context,
      small: small,
      medium: medium,
      large: large,
    );

    return isVertical ? SizedBox(height: spacing) : SizedBox(width: spacing);
  }

  static Widget createResponsiveSizedBox({
    required BuildContext context,
    double? height,
    double? width,
    Widget? child,
  }) {
    return SizedBox(height: height, width: width, child: child);
  }

  static double getResponsiveFontSizeByWidth(
    BuildContext context, {
    double baseSize = 16,
    double smallMultiplier = 0.8,
    double mediumMultiplier = 1.0,
    double largeMultiplier = 1.2,
  }) {
    final width = getWidth(context);
    if (width < 600) return baseSize * smallMultiplier;
    if (width < 900) return baseSize * mediumMultiplier;
    return baseSize * largeMultiplier;
  }

  static double getResponsiveHeightByHeight(
    BuildContext context, {
    double baseHeight = 100,
    double smallMultiplier = 0.8,
    double mediumMultiplier = 1.0,
    double largeMultiplier = 1.2,
  }) {
    final height = getHeight(context);
    if (height < 600) return baseHeight * smallMultiplier;
    if (height < 800) return baseHeight * mediumMultiplier;
    return baseHeight * largeMultiplier;
  }
}

enum DeviceSize { small, medium, large }

DeviceSize getDeviceSize(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < 600) return DeviceSize.small;
  if (width < 900) return DeviceSize.medium;
  return DeviceSize.large;
}

double getResponsiveFontSize(
  BuildContext context, {
  double small = 14,
  double medium = 16,
  double large = 18,
}) {
  final deviceSize = getDeviceSize(context);
  switch (deviceSize) {
    case DeviceSize.small:
      return small;
    case DeviceSize.medium:
      return medium;
    case DeviceSize.large:
      return large;
  }
}

double getResponsiveSpacing(
  BuildContext context, {
  double small = 8,
  double medium = 12,
  double large = 16,
}) {
  final deviceSize = getDeviceSize(context);
  switch (deviceSize) {
    case DeviceSize.small:
      return small;
    case DeviceSize.medium:
      return medium;
    case DeviceSize.large:
      return large;
  }
}

bool isLandscape(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.landscape;
}

EdgeInsets getSafeAreaPadding(BuildContext context) {
  return MediaQuery.of(context).padding;
}

class DeviceValidator {
  static bool isVerySmallScreen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.height < 600 || size.width < 320;
  }

  static bool isExtraSmallScreen(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.height < 500 || size.width < 280;
  }

  static bool hasNotch(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return padding.top > 20 || padding.bottom > 0;
  }

  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > 600 && size.height > 600;
  }

  static bool isPhone(BuildContext context) {
    return !isTablet(context);
  }

  static double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static bool isHighDPI(BuildContext context) {
    return getPixelRatio(context) >= 2.0;
  }

  static double getScreenDensity(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  static double getAspectRatio(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width / size.height;
  }

  static bool isSquareScreen(BuildContext context) {
    final aspectRatio = getAspectRatio(context);
    return aspectRatio >= 0.8 && aspectRatio <= 1.2;
  }

  static bool isWideScreen(BuildContext context) {
    final aspectRatio = getAspectRatio(context);
    return aspectRatio > 1.5;
  }

  static bool isTallScreen(BuildContext context) {
    final aspectRatio = getAspectRatio(context);
    return aspectRatio < 0.7;
  }

  static double getRecommendedFontSize(
    BuildContext context, {
    double baseSize = 16,
    double smallMultiplier = 0.8,
    double mediumMultiplier = 1.0,
    double largeMultiplier = 1.2,
  }) {
    final deviceSize = getDeviceSize(context);
    switch (deviceSize) {
      case DeviceSize.small:
        return baseSize * smallMultiplier;
      case DeviceSize.medium:
        return baseSize * mediumMultiplier;
      case DeviceSize.large:
        return baseSize * largeMultiplier;
    }
  }

  static double getRecommendedButtonHeight(BuildContext context) {
    final deviceSize = getDeviceSize(context);
    switch (deviceSize) {
      case DeviceSize.small:
        return 40;
      case DeviceSize.medium:
        return 45;
      case DeviceSize.large:
        return 50;
    }
  }

  static double getRecommendedIconSize(BuildContext context) {
    final deviceSize = getDeviceSize(context);
    switch (deviceSize) {
      case DeviceSize.small:
        return 20;
      case DeviceSize.medium:
        return 24;
      case DeviceSize.large:
        return 28;
    }
  }


  static EdgeInsets getRecommendedPadding(BuildContext context) {
    final deviceSize = getDeviceSize(context);
    switch (deviceSize) {
      case DeviceSize.small:
        return const EdgeInsets.all(12);
      case DeviceSize.medium:
        return const EdgeInsets.all(16);
      case DeviceSize.large:
        return const EdgeInsets.all(20);
    }
  }

  static EdgeInsets getRecommendedMargin(BuildContext context) {
    final deviceSize = getDeviceSize(context);
    switch (deviceSize) {
      case DeviceSize.small:
        return const EdgeInsets.all(8);
      case DeviceSize.medium:
        return const EdgeInsets.all(12);
      case DeviceSize.large:
        return const EdgeInsets.all(16);
    }
  }

  static bool hasPhysicalKeyboard(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom == 0;
  }

  static double getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  static bool isKeyboardVisible(BuildContext context) {
    return getKeyboardHeight(context) > 0;
  }

  static Brightness getScreenBrightness(BuildContext context) {
    return MediaQuery.of(context).platformBrightness;
  }

  static bool isDarkMode(BuildContext context) {
    return getScreenBrightness(context) == Brightness.dark;
  }



  static Map<String, dynamic> getDeviceInfo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return {
      'width': size.width,
      'height': size.height,
      'pixelRatio': getPixelRatio(context),
      'deviceSize': getDeviceSize(context).toString(),
      'orientation': isLandscape(context) ? 'landscape' : 'portrait',
      'hasNotch': hasNotch(context),
      'isTablet': isTablet(context),
      'isPhone': isPhone(context),
      'aspectRatio': getAspectRatio(context),
      'safeAreaTop': padding.top,
      'safeAreaBottom': padding.bottom,
      'safeAreaLeft': padding.left,
      'safeAreaRight': padding.right,
    };
  }

  static Widget createResponsiveWidget({
    required BuildContext context,
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? height,
    double? width,
  }) {
    return Container(
      padding: padding ?? getRecommendedPadding(context),
      margin: margin ?? getRecommendedMargin(context),
      height: height,
      width: width,
      child: child,
    );
  }

  static Widget createResponsiveText({
    required BuildContext context,
    required String text,
    TextStyle? style,
    double baseSize = 16,
    double smallMultiplier = 0.9,
    double mediumMultiplier = 1.0,
    double largeMultiplier = 1.1,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return Text(
      text,
      style:
          style?.copyWith(
            fontSize: getRecommendedFontSize(
              context,
              baseSize: baseSize,
              smallMultiplier: smallMultiplier,
              mediumMultiplier: mediumMultiplier,
              largeMultiplier: largeMultiplier,
            ),
          ) ??
          TextStyle(
            fontSize: getRecommendedFontSize(
              context,
              baseSize: baseSize,
              smallMultiplier: smallMultiplier,
              mediumMultiplier: mediumMultiplier,
              largeMultiplier: largeMultiplier,
            ),
          ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  static Widget createResponsiveButton({
    required BuildContext context,
    required String text,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? textColor,
    double? width,
    EdgeInsets? padding,
    BorderRadius? borderRadius,
  }) {
    return SizedBox(
      width: width ?? double.infinity,
      height: getRecommendedButtonHeight(context),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
          padding: padding,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: getRecommendedFontSize(
              context,
              baseSize: 16,
              smallMultiplier: 0.9,
              mediumMultiplier: 1.0,
              largeMultiplier: 1.1,
            ),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

DateTime? convertStringToDate(String date) {
  try {
    return DateTime.parse(date);
  } catch (e) {
    return null;
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> writeDebugDataToFile(String fileName, String content) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/$fileName';
    final file = File(path);
    await file.writeAsString(content, mode: FileMode.write, flush: true);
    debugPrint('Saved log to $path');
  } catch (e) {
    debugPrint('Error writing log file: $e');
  }
}
