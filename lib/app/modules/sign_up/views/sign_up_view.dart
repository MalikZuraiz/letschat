import 'package:flutter/material.dart';
import 'package:letschat/app/routes/app_pages.dart';
import 'package:letschat/widgets/customized_textfield.dart';
import 'package:get/get.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            _buildHeading(),
            const SizedBox(height: 30),
            CustomTextField(
              label: 'Enter your name',
              controller: controller.nameController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Enter your Email',
              controller: controller.emailController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Enter your Password',
              isPassword: true,
              controller: controller.passwordController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Enter your Confirm Password',
              isPassword: true,
              controller: controller.confirmPasswordController,
            ),
            const SizedBox(height: 30),
            _buildCustomButton('Sign Up', () {
              controller.signUp();
            }),
            const SizedBox(height: 20),
            _buildOrSignInWithText(),
            const Spacer(),
            _buildSignInText(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Method to create the heading
  Widget _buildHeading() {
    return const Text(
      'Create an account',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Method to create a custom button
  Widget _buildCustomButton(String text, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.blueAccent],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  // Method to create the "or sign in with" text
  Widget _buildOrSignInWithText() {
    return const Center(
      child: Text('or sign up with'),
    );
  }

  // Method to create "Already have an account? Sign In" text
  Widget _buildSignInText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? "),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.SIGN_IN);
          },
          child: const Text(
            'Sign In',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
