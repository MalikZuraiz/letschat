import 'package:letschat/config/app_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;

  UserModel({
    this.id,
    this.name,
    this.email,
  });

  // Method to convert UserModel to a map for Firestore, ignoring null values
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    if (id != null) data[UserKey.USER_ID] = id;
    if (name != null) data[UserKey.USER_NAME] = name;
    if (email != null) data[UserKey.USER_EMAIL] = email;
    return data;
  }

  // Factory method to create a UserModel from a Firestore document
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[UserKey.USER_ID],
      name: map[UserKey.USER_NAME],
      email: map[UserKey.USER_EMAIL],
    );
  }

  // Method to create UserModel from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: data[UserKey.USER_ID],
      name: data[UserKey.USER_NAME],
      email: data[UserKey.USER_EMAIL],
    );
  }
}
