import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_tab_controller.dart';

class ProfileTabView extends GetView<ProfileTabController> {
  const ProfileTabView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'ProfileTabView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
