import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:letschat/app/modules/sign_up/model/user_model.dart';
import 'package:letschat/service/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final UserService _userService = UserService();

  // Method to upload profile image and return the URL
  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      final storageRef = _storage.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}');
      await storageRef.putFile(imageFile);
      return await storageRef.getDownloadURL();
    } catch (e) {
      log("Error uploading profile image: $e");
      return null;
    }
  }

  // Sign up method
  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String name,
    required DateTime dateOfBirth,
    String? bio,
    String? profileImageUrl,
    String? phoneNumber,
  }) async {
    try {
      // Create user with Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      // Create a new user model with all required fields
      UserModel newUser = UserModel(
        id: user?.uid ?? '',
        username: name,
        email: email,
        createdDate: DateTime.now(),
        devices: [], // Initially empty list of devices, can be updated later
        signInMethod: 'email', // Assuming sign-up via email for this example
        dateOfBirth: dateOfBirth,
        bio: bio ?? '',
        phoneNumber: phoneNumber ?? '',
        profileImageUrl: profileImageUrl ?? '',
        isOnline: false,
        lastSeen: DateTime.now(), // Default to current time for last seen
        friends: [],
        interests: [], // Empty interests, can be updated later
        connectionRequests: [],
        pendingRequests: [],
        allowDirectMessagesFromNonFriends: true,
        allowNonFriendsToSeePosts: true,
        notificationsEnabled: true,
        theme: 'light',
      );

      // Store user data in Firestore using UserService
      await _userService.createUser(newUser);

      return newUser;
    } catch (e) {
      log("Error during sign up: $e");
      return null;
    }
  }

  // Other authentication methods remain unchanged...

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
