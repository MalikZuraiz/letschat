import 'package:get/get.dart';

import '../controllers/create_new_password_controller.dart';

class CreateNewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    final String? email = Get.arguments != null ? Get.arguments['email'] : null;
    if (email != null) {
      Get.lazyPut<CreateNewPasswordController>(
        () => CreateNewPasswordController(email),
      );
    } else {
      // Handle the case where email is null, e.g., by showing an error or navigating back
      print("Error: No email provided");
      Get.snackbar("Error", "No email provided", snackPosition: SnackPosition.BOTTOM);
      Get.back(); // or handle error accordingly
    }
  }
}
