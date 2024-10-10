import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import your tab pages
import '../controllers/landing_page_controller.dart';
import 'package:letschat/app/modules/chatTab/views/chat_tab_view.dart';
import 'package:letschat/app/modules/shortsTab/views/shorts_tab_view.dart';
import 'package:letschat/app/modules/profileTab/views/profile_tab_view.dart';

// import '../views/shorts_tab.dart';
// import '../views/profile_tab.dart';

class LandingPageView extends GetView<LandingPageController> {
  const LandingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,  // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Let\'s Chat'),  // Set the title to the app's name
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.chat), text: 'Chat'),
              Tab(icon: Icon(Icons.video_library), text: 'Shorts'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const ChatTabView(),  // Reference to ChatTab
            ShortsTabView(),  // Reference to ShortsTab
            ProfileTabView(),  // Reference to ProfileTab
          ],
        ),
      ),
    );
  }
}
