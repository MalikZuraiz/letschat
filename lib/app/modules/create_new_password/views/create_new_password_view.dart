import 'package:flutter/material.dart';
import 'package:letschat/app/routes/app_pages.dart';
import 'package:letschat/config/app_images.dart';
import 'package:letschat/widgets/customized_reuse_button.dart';
import 'package:letschat/widgets/customized_textfield.dart';
import 'package:get/get.dart';
import '../controllers/create_new_password_controller.dart';

class CreateNewPasswordView extends GetView<CreateNewPasswordController> {
  const CreateNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the email passed from the previous screen (Forgot Password)
    final String? email = Get.arguments?['email'];
    

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Main Page content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top left back button
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Circular shape for the button
                    border: Border.all(color: Colors.grey, width: 0),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back(); // Navigate back
                    },
                    icon: const Icon(Icons.arrow_back),
                    padding: const EdgeInsets.all(8),
                    iconSize: 20,
                  ),
                ),
                const SizedBox(height: 20),

                // Heading
                const Text(
                  'Create new password',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Instruction text
                const Text(
                  'Your new password must be different from previously used passwords.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
                const SizedBox(height: 40),

                // Password field
                Obx(() => CustomTextField(
                  controller: controller.passwordController,
                      label: 'Password',
                      isPassword: !controller.isPasswordVisible.value,
                      suffixIcon: IconButton(
                        color: Colors.grey,
                        icon: Icon(controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    )),
                const SizedBox(height: 20),

                // Confirm password field
                Obx(() => CustomTextField(
                  controller: controller.confirmPasswordController,
                      label: 'Confirm Password',
                      isPassword: !controller.isConfirmPasswordVisible.value,
                      suffixIcon: IconButton(
                        color: Colors.grey,
                        icon: Icon(controller.isConfirmPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                    )),
                const SizedBox(height: 80),

                // Confirm button
                Center(
                  child: CustomButton(
                    text: 'Confirm',
                    onTap: () {

                      if (controller.passwordController.value.text == controller.confirmPasswordController.value.text) {
                        controller.confirmPasswordChange(controller.passwordController.value.text);
                      } else {
                        Get.snackbar("Error", "Passwords do not match.",
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    backgroundColor: Colors.black, // Button color
                    width: 300, // Adjust width of the button as required
                  ),
                ),
              ],
            ),
          ),

          // Dark overlay and ClipRect showing after Confirm is clicked
          Obx(() => controller.isPasswordChanged.value
              ? _buildPasswordChangedOverlay(context)
              : const SizedBox()),
        ],
      ),
    );
  }

  // Dark overlay with Password Changed widget in ClipRect
  Widget _buildPasswordChangedOverlay(BuildContext context) {
    return Stack(
      children: [
        // Dark overlay on the rest of the screen
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.6), // Dark overlay with 60% opacity
        ),

        // ClipRect taking 40% of the height, sliding from the bottom
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRect(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width, // Full width of the screen
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Image.asset(
                      AppImages.SUCCESS_ICON,
                      width: 60,
                      height: 60,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Your password has been changed',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Welcome back! Discover now!',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 40),

                  // Custom button reused inside the widget
                  CustomButton(
                    text: 'Browse home',
                    onTap: () {
                      Get.offAllNamed(Routes.LANDING_PAGE);
                    },
                    backgroundColor: Colors.black, // Button color
                    width: MediaQuery.of(context).size.width * 0.8, // 80% width
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
