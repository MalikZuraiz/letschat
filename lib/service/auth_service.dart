import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:letschat/app/modules/sign_up/model/user_model.dart';
import 'package:letschat/service/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserService _userService = UserService();

  // Sign up method
  Future<UserModel?> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      // Create user with Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      // Create a new user model
      UserModel newUser = UserModel(
        id: user?.uid,
        name: name,
        email: email,
      );

      // Store user data in Firestore using UserService
      await _userService.createUser(newUser);

      return newUser;
    } catch (e) {
      log("Error during sign up $e");
      return null;
    }
  }

  // Login method
  Future<User?> login({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in the user with Firebase Auth
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      log("Error during login: $e");
      return null;
    }
  }

  // Logout method
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Error during logout: $e");
    }
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
