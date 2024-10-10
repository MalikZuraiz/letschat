import 'package:flutter/material.dart';
import 'package:letschat/app/routes/app_pages.dart';
import 'package:letschat/service/auth_service.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final AuthService _authService = AuthService();

  // Controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Method to handle login
  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password are required');
      return;
    }

    try {
      var user = await _authService.login(email: email, password: password);
      if (user != null) {
        Get.snackbar('Success', 'Logged in successfully');
        Get.offAllNamed(
            Routes.LANDING_PAGE); // Redirect to home page after successful login
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to log in. Please try again.');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
