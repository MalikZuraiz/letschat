import 'package:get/get.dart';

class LandingPageController extends GetxController {
  // Observed variable for the selected tab index
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Method to update the selected tab index
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
