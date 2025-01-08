import 'package:flutter/material.dart';
import 'package:letschat/app/routes/app_pages.dart';
import 'package:letschat/service/auth_service.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final AuthService _authService = AuthService();

  // Controllers for text fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs; // Observable to track loading state

  // Method to handle login
  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    isLoading.value = true; // Set loading state to true


    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password are required');
      return;
    }

    try {
      var user = await _authService.login(email: email, password: password);
      if (user != null) {
        Get.snackbar('Success', 'Logged in successfully');
        Get.offAllNamed(
            Routes.LANDING_PAGE); 
      }
    } catch (e) {
      // Handle sign-in error
      Get.snackbar('Error', 'Login failed: $e');
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
