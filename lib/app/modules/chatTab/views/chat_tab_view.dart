import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/chat_tab_controller.dart';

class ChatTabView extends GetView<ChatTabController> {
  const ChatTabView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: const Center(
        child: Text(
          'ChatTabView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
