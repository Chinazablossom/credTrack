import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../../core/auth/auth.dart';
import '../../../../../core/utils/common/snack_bars.dart';
import '../../../../../core/utils/common/success_screen.dart';

class EmailVerificationController extends GetxController {
  static EmailVerificationController get instance => Get.find();

  final isEmailVerified = false.obs;

  final userEmail = "".obs;

  @override
  void onInit() {
    sendEmailVerificationLink();
    setTimerForAutoRedirect();
    super.onInit();
  }

  verifyEmail() async {}

  void sendEmailVerificationLink() async {
    try {
      await AuthenticationRepo.instance.sendUserEmailVerification();
      SnackBars.displaySnackBar(
          title: "Email Sent",
          message: "We have sent a verification link to your email",
        isSuccess: true
      );
    } catch (e) {
      SnackBars.displaySnackBar(title: "Oh Snap!...", message: e.toString(), isError: true);
    }
  }

  setTimerForAutoRedirect() {
    Timer.periodic(
        const Duration(seconds: 1),
            (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
              title: "Email Verified!",
              subTitle: "You can now proceed scholar",
              onPressed: () => AuthenticationRepo.instance.screenNavigation(),
            ));
      }
    });
  }

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
            title: "Email Verified!",
            subTitle: "You can now proceed scholar",
            onPressed:() =>  AuthenticationRepo.instance.screenNavigation(),
          ));
    }
    else {
      SnackBars.displaySnackBar(
          title: "Opps...",
          message: "Email not verified yet, please check your mail",
          isWarning: true);
    }
  }
}
