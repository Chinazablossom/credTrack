import 'package:cred_track/core/utils/helper_functions/extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../constants/asset_paths.dart';
import '../helper_functions/helper_functions.dart';

class SnackBars {
  static hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static void displaySnackBar({
    String? icon,
    String? imageUrl,
    required title,
    message = "",
    int duration = 4,
    bool isError = false,
    bool isSuccess = false,
    bool isInfo = false,
    bool isWarning = false,
  }) {
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay == null) {
      debugPrint('No overlay available for custom snackbar.');
      return;
    }
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 12,
        left: 24,
        right: 24,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: -40, end: 0),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, value),
                child: child,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: getCardTheme(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isError
                      ? Color(0x80401018)
                      : isSuccess
                      ? Color(0x66043823)
                      : isInfo
                      ? getTheme(context).primary.withAlpha(180)
                      : isWarning
                      ? Color(0x80986813)
                      : Colors.transparent,
                  width: 4.8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(150),
                    blurRadius: 65,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: isError
                          ? const Color(0xffBF3048)
                          : isSuccess
                          ? const Color(0xff30BF8F)
                          : isInfo
                          ? getTheme(context).primary
                          : isWarning
                          ? Colors.orangeAccent
                          : const Color(0xffBF3048),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Builder(
                          builder: (_) {
                            if (imageUrl != null && imageUrl.isNotEmpty) {
                              final isRemote = imageUrl.startsWith('http');
                              if (isRemote) {
                                return Image.network(
                                  imageUrl,
                                  width: 42,
                                  height: 42,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) {
                                    return SvgPicture.asset(icon ?? alertSvg);
                                  },
                                );
                              } else {
                                return Image.file(
                                  File(imageUrl),
                                  width: 42,
                                  height: 42,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, e, s) {
                                    return SvgPicture.asset(icon ?? alertSvg);
                                  },
                                );
                              }
                            }
                            return SvgPicture.asset(
                              icon ?? alertSvg,
                              width: 24,
                              height: 24,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  16.w,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: getTextTheme(context).labelSmall,
                        ),
                        3.h,
                        Text(
                          message,
                          style: getTextTheme(context).bodySmall?.copyWith(
                            color: getTheme(context).onSurfaceVariant
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);
    Future.delayed(Duration(seconds: duration), () => entry.remove());
  }
}
