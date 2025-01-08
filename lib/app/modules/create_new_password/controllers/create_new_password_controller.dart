import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateNewPasswordController extends GetxController {
  // Observables to handle the visibility of password fields
  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxBool isPasswordChanged = false.obs;
  RxBool isLoading = false.obs; // Observable for loading state
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Constructor to receive the email
  CreateNewPasswordController(this.email);
  final String? email;

  // Function to toggle the password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Function to toggle the confirm password visibility
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Function to handle password confirmation logic
  Future<void> confirmPasswordChange(String newPassword) async {
    // Start loading indicator
    isLoading.value = true;

    try {
      // Fetch the user's document from Firestore using the email
      QuerySnapshot userQuery = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (userQuery.docs.isNotEmpty) {
        // Retrieve the user document
        DocumentSnapshot userDoc = userQuery.docs.first;

        // Get the UID and signInMethod from the user document
        String uid = userDoc.id; // Get the UID from the document ID
        String signInMethod = userDoc['signInMethod'];

        // Proceed only if the user signed in with email/password
        if (signInMethod == 'email') {
          // Use the retrieved UID to update the password
          User? user = _auth.currentUser;

          if (user != null && user.uid == uid) {
            // Update the user's password
            await user.updatePassword(newPassword);
            // Indicate success by changing isPasswordChanged to true
            isPasswordChanged.value = true;
          } else {
            // Snackbar for users who did not sign in with email/password
            Get.snackbar(
              "Error",
              "You must be signed in with email and password to change your password.",
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        } else {
          // Snackbar for users who did not sign in with email/password
          Get.snackbar(
            "Error",
            "You must be signed in with email and password to change your password.",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        // Handle case when the user document does not exist
        Get.snackbar(
          "Error",
          "User document not found.",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Handle error and display message
      Get.snackbar(
        "Error",
        "Failed to update password: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      // Stop loading indicator
      isLoading.value = false;
    }
  }
}
