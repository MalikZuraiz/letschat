import 'package:flutter/material.dart';
import 'package:letschat/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:letschat/app/modules/sign_up/model/user_model.dart';
import 'package:letschat/service/auth_service.dart';

class SignUpController extends GetxController {
  final AuthService _authService = AuthService();

  // Form input controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Method to handle sign-up logic
  Future<void> signUp() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      UserModel? newUser = await _authService.signUp(
        email: email,
        password: password,
        name: name.isNotEmpty ? name : null,
      );

      if (newUser != null) {
        Get.snackbar('Success', 'User signed up successfully');
        // Navigate to the next screen, e.g., home page
        Get.offAllNamed(Routes.LANDING_PAGE);
      } else {
        Get.snackbar('Error', 'Failed to sign up');
      }
    } catch (e) {
      Get.snackbar('Error', 'Sign up failed: $e');
    }
  }

  @override
  void onClose() {
    // Dispose of controllers to avoid memory leaks
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
