import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/data/models/user.dart';
import '../../../../core/utils/common/screen_loader.dart';
import '../../../../core/utils/common/snack_bars.dart';
import '../../../../core/utils/common/network_manager.dart';
import '../../../../core/auth/auth.dart';
import '../../../../core/utils/exceptions/auth_exceptions.dart';
import '../../../../core/data/repositories/user_repo.dart';
import '../../../../core/data/local/dao/user_dao.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final userName = TextEditingController();
  final email = TextEditingController();
  final countryCode = "".obs;
  final credPalId = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final isVerifying = false.obs;
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final authInstance = AuthenticationRepo.instance;

  void signUp() async {
    if (isVerifying.value) return;
    isVerifying.value = true;

    try {
      if (!signUpFormKey.currentState!.validate()) {
        isVerifying.value = false;
        return;
      }

      final isConnectedToInternet = await NetworkManager.instance.isConnected();
      if (!isConnectedToInternet) {
        SnackBars.displaySnackBar(
          title: "Oh snap!...",
          message: "You're not connected to the internet",
          isWarning: true,
        );
        isVerifying.value = false;
        return;
      }

      ScreenLoader.openLoadingDialog(
        "We're creating your account - hang tight!",
      );

      final userCredential = await authInstance.signUpUserWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      final newUser = UserModel(
        userID: userCredential.user!.uid,
        userName: userName.text.trim(),
        userEmail: email.text.trim(),
        userCredPalId: credPalId.text.trim(),
        userImage: '',
      );

      await Get.put(UserRepository()).saveUserRecord(newUser);
      await UserDao.instance.upsertUser(newUser);
      ScreenLoader.stopLoading();
      SnackBars.displaySnackBar(
        title: "Congratulations!",
        message: "Your account has been created!",
        isSuccess: true,
      );

      AuthenticationRepo.instance.screenNavigation();
    } catch (e, st) {
      ScreenLoader.stopLoading();
      SnackBars.displaySnackBar(
        title: "Sign up Failed",
        message: "Something went wrong. Please try again.",
        isError: true,
      );
    } finally {
      isVerifying.value = false;
    }
  }

  Future<void> googleSignIn() async {
    if (isVerifying.value) return;
    isVerifying.value = true;

    try {
      final isConnectedToInternet = await NetworkManager.instance.isConnected();

      if (!isConnectedToInternet) {
        ScreenLoader.stopLoading();
        SnackBars.displaySnackBar(
          title: "Oh no...",
          message: "You're not connected to the internet",
          isWarning: true,
        );
        return;
      }

      ScreenLoader.openLoadingDialog("Signing in with Google...");

      await AuthenticationRepo.instance.signInWithGoogle();

      final u = FirebaseAuth.instance.currentUser;
      if (u != null) {
        final newUser = UserModel(
          userID: u.uid,
          userName: u.displayName ?? 'CredTracker',
          userEmail: u.email ?? '',
          userCredPalId: '',
          userImage: u.photoURL ?? '',
        );

        await UserDao.instance.upsertUser(newUser);
      }

      ScreenLoader.stopLoading();
      AuthenticationRepo.instance.screenNavigation();
    } catch (e, st) {
      ScreenLoader.stopLoading();
      SnackBars.displaySnackBar(
        title: "Google Sign-in Failed",
        message: e.toString(),
        isError: true,
      );

    } finally {
      isVerifying.value = false;
    }
  }
}
