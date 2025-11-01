import 'package:cred_track/core/utils/constants/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../core/utils/helper_functions/helper_functions.dart';
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = getTextTheme(context);
    final theme = getTheme(context);

    return Scaffold(
      backgroundColor: theme.primary,
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([
            controller.credtController,
            controller.txtController,
            controller.centerController,
          ]),
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, controller.credSlide.value.dy * 100),
                  child: Transform.scale(
                    scale: controller.credScale.value,
                    child: SvgPicture.asset(credTrackSvg,
                    height: 140,
                      width: 140,
                      color: theme.onPrimary,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, controller.txtSlide.value.dy * 100),
                  child: Opacity(
                    opacity: controller.txtController.value,
                    child: Text(
                      "CredTrack",
                      style: textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: getTheme(context).onPrimary,
                        letterSpacing: 2.5,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
