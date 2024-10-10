import 'package:flutter/material.dart';
import 'package:letschat/app/routes/app_pages.dart';
import 'package:letschat/widgets/customized_textfield.dart';
import 'package:get/get.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            _buildHeading(),
            const SizedBox(height: 30),
            CustomTextField(
              label: 'Enter your Email',
              controller: controller.emailController, // Use controller
            ),
            const SizedBox(height: 20),
            CustomTextField(
              label: 'Enter your Password',
              isPassword: true,
              controller: controller.passwordController, // Use controller
            ),
            const SizedBox(height: 30),
            _buildCustomButton('Log In', () {
              controller.login(); // Trigger login action
            }),
            const SizedBox(height: 20),
            _buildOrSignInWithText(),
            const Spacer(),
            _buildSignUpText(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading() {
    return const Text(
      'Welcome Back',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

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

  Widget _buildOrSignInWithText() {
    return const Center(
      child: Text('or log in with'),
    );
  }

  Widget _buildSignUpText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.SIGN_UP); // Navigate to sign-up screen
          },
          child: const Text(
            'Sign Up',
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
