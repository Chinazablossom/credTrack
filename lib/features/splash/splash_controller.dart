import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../../../../core/auth/auth.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController credtController;
  late AnimationController txtController;
  late AnimationController centerController;

  late Animation<double> credScale;
  late Animation<Offset> credSlide;
  late Animation<Offset> txtSlide;
  late Animation<Offset> finalCenter;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    credtController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    txtController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    centerController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    credScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: credtController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    credSlide =
        Tween<Offset>(
          begin: const Offset(0, -1.5),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: credtController,
            curve: const Interval(0.0, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    txtSlide =
        Tween<Offset>(
          begin: const Offset(0, 1.5),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: txtController,
            curve: Curves.easeOutCubic,
          ),
        );

    finalCenter = Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(
      CurvedAnimation(parent: centerController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() async {
    await credtController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    await txtController.forward();

    await centerController.forward();

    await Future.delayed(const Duration(milliseconds: 500));
    _navigateToAuthLogic();
  }

  void _navigateToAuthLogic() {
    if (!Get.isRegistered<AuthenticationRepo>()) {
      Get.put(AuthenticationRepo());
    }
   AuthenticationRepo.instance.screenNavigation();
  }

  @override
  void onClose() {
    credtController.dispose();
    txtController.dispose();
    centerController.dispose();
    super.onClose();
  }
}
