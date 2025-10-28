import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/auth/auth.dart';
import '../../../../core/utils/common/network_manager.dart';
import '../../../../core/utils/common/screen_loader.dart';
import '../../../../core/utils/common/snack_bars.dart';
import '../../../../core/utils/exceptions/auth_exceptions.dart';
import '../../../../core/utils/device/storage_utils.dart';
import '../../../../core/data/local/dao/user_dao.dart';
import '../../../../core/data/models/user.dart';

const String rememberMeMail = 'remember_me_email';
const String rememberMePassword = 'remember_me_password';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final hidePassword = true.obs;
  final rememberMe = false.obs;
  final isVerifying = false.obs;
  final DeviceStorage localStorage = DeviceStorage();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> emailAndPasswordLogin() async {
    if (isVerifying.value) return;
    isVerifying.value = true;

    try {
      if (!loginFormKey.currentState!.validate()) {
        ScreenLoader.stopLoading();
        return;
      }

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

      ScreenLoader.openLoadingDialog("Signing in...");

      final userCredentials = await AuthenticationRepo.instance
          .logUserInWithEmailAndPassword(
            email.text.trim(),
            password.text.trim(),
          );

      // local user record for offline use
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final localUser = UserModel(
          userID: currentUser.uid,
          userName: currentUser.displayName ?? 'CredTracker',
          userEmail: currentUser.email ?? email.text.trim(),
          userCredPalId: '',
          userImage: currentUser.photoURL ?? '',
        );
        await UserDao.instance.upsertUser(localUser);
      }
      SnackBars.displaySnackBar(
        title: "Welcome",
        message: "You're now signed in",
        isSuccess: true,
      );
      ScreenLoader.stopLoading();
      AuthenticationRepo.instance.screenNavigation();
      clearFields();
    } catch (e, st) {
      ScreenLoader.stopLoading();

      SnackBars.displaySnackBar(
        title: "Login Failed",
        message: e.toString(),
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

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final localUser = UserModel(
          userID: currentUser.uid,
          userName: currentUser.displayName ?? 'CredTracker',
          userEmail: currentUser.email ?? '',
          userCredPalId: '',
          userImage: currentUser.photoURL ?? '',
        );
        await UserDao.instance.upsertUser(localUser);
      }

      SnackBars.displaySnackBar(
        title: "Welcome",
        message: "You're now signed in",
        isSuccess: true,
      );
      ScreenLoader.stopLoading();

      AuthenticationRepo.instance.screenNavigation();
      clearFields();
    } catch (e, st) {
      ScreenLoader.stopLoading();

      SnackBars.displaySnackBar(
        title: "Google Sign-in Failed",
        message: e.toString(),
      );
    } finally {
      isVerifying.value = false;
    }
  }

  void clearFields() {
    email.clear();
    password.clear();
  }
}
