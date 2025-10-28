import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("users").doc(user.userID).set(user.toJson());
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    } on FormatException catch (e) {
      throw Exception(e.message);
    } on PlatformException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  /// Stream the current user's profile document
  Stream<UserModel?> streamUserById(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((snap) {
      if (!snap.exists) return null;
      return UserModel.fromSnapshot(snap);
    });
  }

  /// Fetch the current user's profile document once
  Future<UserModel?> getUserById(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      if (!doc.exists) return null;
      return UserModel.fromSnapshot(doc);
    } catch (e) {
      rethrow;
    }
  }

  /// Update fields in the user's document
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
  }
}
