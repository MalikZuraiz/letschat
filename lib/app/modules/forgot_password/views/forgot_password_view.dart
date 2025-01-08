import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letschat/app/routes/app_pages.dart';
import 'package:letschat/widgets/customized_textfield.dart';
import 'package:letschat/widgets/customized_reuse_button.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top left back button
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey, width: 0),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back),
                    padding: const EdgeInsets.all(8),
                    iconSize: 20,
                  ),
                ),
                const SizedBox(height: 20),

                // Forgot Password Heading
                const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Description Text
                const Text(
                  'Enter Email Associated With Your Account and\n'
                  'We\'ll send an Email with Instructions to \n'
                  'Reset Your Password',
                  style: TextStyle(
                      fontSize: 15, height: 1.5, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 50),

                // Email Input
                CustomTextField(
                  label: 'Enter your Email Here',
                  controller: controller.emailController,
                ),
                const SizedBox(height: 80),

                // Custom button for "Reset Password"
                Center(
                  child: CustomButton(
                    text: 'Reset Password',
                    onTap: () {
                      if (!controller.isLoading.value) {
                        controller.checkEmailExists();
                      }
                    },
                    backgroundColor: Colors.black,
                    width: 300,
                  ),
                ),
              ],
            ),
          ),

          // Loading Overlay
          Obx(() => controller.isLoading.value
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
