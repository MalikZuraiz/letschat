import 'package:get/get.dart';

import '../controllers/shorts_tab_controller.dart';

class ShortsTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShortsTabController>(
      () => ShortsTabController(),
    );
  }
}
