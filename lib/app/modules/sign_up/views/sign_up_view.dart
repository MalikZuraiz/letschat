import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letschat/app/routes/app_pages.dart';
import 'package:letschat/config/app_images.dart';
import 'package:letschat/widgets/customized_reuse_button.dart';
import 'package:letschat/widgets/customized_textfield.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                _buildHeading(),
                const SizedBox(height: 30),
                _buildProfileImagePicker(),
                const SizedBox(height: 20),
                CustomTextField(controller: controller.nameController, label: 'Enter your name'),
                const SizedBox(height: 20),
                CustomTextField(controller: controller.emailController, label: 'Enter your Email'),
                const SizedBox(height: 20),
                CustomTextField(controller: controller.passwordController, label: 'Enter your Password', isPassword: true),
                const SizedBox(height: 20),
                CustomTextField(controller: controller.confirmPasswordController, label: 'Enter your Confirm Password', isPassword: true),
                const SizedBox(height: 20),
                CustomTextField(controller: controller.bioController, label: 'Enter a short bio (optional)'),
                const SizedBox(height: 20),
                CustomTextField(controller: controller.phoneNumberController, label: 'Enter your phone number (optional)', keyboardType: TextInputType.phone),
                const SizedBox(height: 20),
                CustomTextField(controller: controller.dobController, label: 'Enter your date of birth (YYYY-MM-DD)', keyboardType: TextInputType.datetime),
                const SizedBox(height: 20),
                _buildGetStartedButton(),
                const SizedBox(height: 20),
                _buildOrSignInWithText(),
                const SizedBox(height: 20),
                _buildSocialIcons(),
                const SizedBox(height: 20),
                _buildSignInText(),
              ],
            ),
          ),
          // Loading overlay
          Obx(() {
            return controller.isLoading.value
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Widget _buildProfileImagePicker() {
    return Center(
      child: GestureDetector(
        onTap: controller.pickImage,
        child: Obx(() {
          return CircleAvatar(
            radius: 50,
            backgroundImage: controller.profileImage.value != null ? FileImage(controller.profileImage.value!) : null,
            child: controller.profileImage.value == null ? const Icon(Icons.camera_alt, size: 50) : null,
          );
        }),
      ),
    );
  }

  Widget _buildHeading() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'your account',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildOrSignInWithText() {
    return const Center(
      child: Text('or sign up with'),
    );
  }

  Widget _buildSocialIcons() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSocialIcon(AppImages.APPLE_ICON),
          const SizedBox(width: 20),
          _buildSocialIcon(AppImages.GOOGLE_ICON),
          const SizedBox(width: 20),
          _buildSocialIcon(AppImages.FB_ICON),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String assetPath) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Image.asset(
          assetPath,
          width: 24,
          height: 24,
        ),
      ),
    );
  }

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

  Widget _buildGetStartedButton() {
    return CustomButton(
      text: 'Sign Up',
      onTap: () {
        controller.signUp();
      },
      backgroundColor: Colors.black,
      width: 300,
    );
  }
}
