import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letschat/app/routes/app_pages.dart';
import 'package:letschat/app/modules/sign_up/model/user_model.dart';
import 'package:letschat/service/auth_service.dart';
import 'package:permission_handler/permission_handler.dart';

class SignUpController extends GetxController {
  final AuthService _authService = AuthService();
  final ImagePicker _picker = ImagePicker();

  // Form input controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bioController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dobController = TextEditingController();
    // Observable to show loading indicator
  var isLoading = false.obs;

  // Observables
  var profileImage = Rx<File?>(null);

Future<void> pickImage() async {
  var cameraStatus = await Permission.camera.request();
  var storageStatus = await Permission.storage.request();
  

  if (cameraStatus.isGranted && storageStatus.isGranted) {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  } else {
    print('Permission denied');
  }
}


  // Method to handle sign-up logic
  Future<void> signUp() async {
    isLoading.value = true; // Show loading indicator

    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String bio = bioController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    DateTime? dob;

    if (dobController.text.isNotEmpty) {
      try {
        dob = DateTime.parse(dobController.text.trim());
      } catch (e) {
        Get.snackbar('Error', 'Invalid date format');
        return;
      }
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      String? profileImageUrl;
      if (profileImage.value != null) {
        profileImageUrl = await _authService.uploadProfileImage(profileImage.value!);
      }

      UserModel? newUser = await _authService.signUp(
        email: email,
        password: password,
        name: name,
        bio: bio,
        profileImageUrl: profileImageUrl,
        phoneNumber: phoneNumber,
        dateOfBirth: dob ?? DateTime(2000, 1, 1),
      );

      if (newUser != null) {
        Get.snackbar('Success', 'User signed up successfully');
        Get.offAllNamed(Routes.LANDING_PAGE);
      } else {
        Get.snackbar('Error', 'Failed to sign up');
      }
    } catch (e) {
      Get.snackbar('Error', 'Sign up failed: $e');
    }
     finally {
      isLoading.value = false; // Hide loading indicator
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    bioController.dispose();
    phoneNumberController.dispose();
    dobController.dispose();
    super.onClose();
  }
}
