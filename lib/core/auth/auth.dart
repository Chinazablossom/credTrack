import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../features/authentication/login/ui/login_screen.dart';
import '../utils/exceptions/auth_exceptions.dart';
import '../utils/device/storage_utils.dart';
import '../data/local/dao/user_dao.dart';

class AuthenticationRepo extends GetxController {
  static AuthenticationRepo get instance => Get.find();

  final DeviceStorage deviceStorage = DeviceStorage();
  final _auth = FirebaseAuth.instance;

  screenNavigation() async {
    final user = _auth.currentUser;
    if (user != null) {
      Get.offAll(() => const LoginScreen());
    } else {
      await deviceStorage.writeIfNull(DeviceStorage.keyIsFirstTime, true);
      final isFirst =
          await deviceStorage.read(DeviceStorage.keyIsFirstTime) == true;

      Get.offAll(() => const LoginScreen());
    }
  }

  /// SIGN UP USER WITH EMAIL AND PASSWORD
  Future<UserCredential> signUpUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw AuthExceptions(e.code).message;
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } on PlatformException catch (e) {
      throw AuthExceptions(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// SEND EMAIL VERIFICATION
  Future<void> sendUserEmailVerification() async {
    try {
      return await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw AuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw AuthExceptions(e.code).message;
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } on PlatformException catch (e) {
      throw AuthExceptions(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// LOG USER IN WITH EMAIL AND PASSWORD
  Future<UserCredential> logUserInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthExceptions(e.code).message;
      // throw Exception(e.code);
    } on FirebaseException catch (e) {
      throw AuthExceptions(e.code).message;
      //throw Exception(e.code);
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } on PlatformException catch (e) {
      throw AuthExceptions(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// GOOGLE SIGN IN
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw AuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw AuthExceptions(e.code).message;
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } on PlatformException catch (e) {
      throw AuthExceptions(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// LOG USER OUT
  Future<void> logOutUser() async {
    try {
      await _auth.signOut();
      await UserDao.instance.clearAll();
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw AuthExceptions(e.code).message;
    } on FirebaseException catch (e) {
      throw AuthExceptions(e.code).message;
    } on FormatException catch (e) {
      throw FormatException(e.message);
    } on PlatformException catch (e) {
      throw AuthExceptions(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
}
