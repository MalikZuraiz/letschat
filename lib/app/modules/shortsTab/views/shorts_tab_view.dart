import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/shorts_tab_controller.dart';

class ShortsTabView extends GetView<ShortsTabController> {
  const ShortsTabView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: const Center(
        child: Text(
          'ShortsTabView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
