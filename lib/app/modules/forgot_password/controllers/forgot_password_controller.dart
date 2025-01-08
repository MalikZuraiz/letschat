import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letschat/app/routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  // Method to check if the email exists in the Firestore 'users' collection
  Future<void> checkEmailExists() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar("Error", "Please enter an email address", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Navigate to Create New Password screen if email exists
       Get.toNamed(Routes.CREATE_NEW_PASSWORD, arguments: {'email': email});
      } else {
        Get.snackbar("Error", "No account found with this email address",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to verify email. Try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
