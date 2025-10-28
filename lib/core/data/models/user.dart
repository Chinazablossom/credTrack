import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userID;
  final String userName;
  final String userEmail;
  final String userCredPalId;
  final String userImage;

  UserModel({
    required this.userID,
    required this.userName,
    required this.userEmail,
    required this.userCredPalId,
    required this.userImage,
  });

  static UserModel empty() => UserModel(
    userID: "",
    userName: "",
    userEmail: "",
    userCredPalId: "",
    userImage: "",
  );

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "userEmail": userEmail,
      "userCredPalId": userCredPalId,
      "userImage": userImage,
    };
  }

  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        userID: document.id,
        userName: data["userName"] ?? "",
        userEmail: data["userEmail"] ?? "",
        userCredPalId: data["userCredPalId"] ?? "",
        userImage: data["userImage"] ?? "",
      );
    } else {
      return UserModel.empty();
    }
  }
}
