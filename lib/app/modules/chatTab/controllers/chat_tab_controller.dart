import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letschat/app/modules/chatTab/model/chat_model.dart';
import 'package:letschat/app/modules/sign_up/model/user_model.dart';
import 'package:letschat/service/chat_service.dart';
import 'package:letschat/service/auth_service.dart';

class ChatTabController extends GetxController {
  var isGroupChatView = false.obs;
  var privateChats = <Chat>[].obs;
  var groupChats = <Chat>[].obs;
  var _searchResults = <UserModel>[].obs;
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    _fetchChats();
  }

  void toggleChatView() {
    isGroupChatView.value = !isGroupChatView.value;
  }

  Future<void> _fetchChats() async {
    try {
      final currentUserId = _authService.getCurrentUser()?.uid;
      if (currentUserId == null) {
        log("Current user ID is null, cannot fetch chats.");
        return; // Early exit if no user is logged in
      }
      final allChats = await _chatService.getAllChats(currentUserId);
      privateChats.value = allChats.where((chat) => !chat.isGroup).toList();
      groupChats.value = allChats.where((chat) => chat.isGroup).toList();
    } catch (e) {
      print('Error fetching chats: $e');
    }
  }

  Future<void> createPrivateChat(String otherUserId) async {
    try {
      final currentUserId = _authService.getCurrentUser()?.uid;
      if (currentUserId == null) {
        log("Cannot create private chat: Current user ID is null.");
        return; // Early exit if no user is logged in
      }

      // Create a new private chat (empty for now)
      Chat newChat = Chat(
        isGroup: false,
        chatName: 'Chat with $otherUserId', // Example name, replace as needed
        profileImage: 'url_to_profile_image', // Replace with actual image URL
        lastMessage: Message(
          messageText: '',
          timestamp: Timestamp.now(),
          senderName: currentUserId,
        ),
      );

      // Call the service to create a private chat
      await _chatService.createPrivateChat(currentUserId, otherUserId);
      _fetchChats(); // Refresh the chats after creating a new chat
    } catch (e) {
      print('Error creating private chat: $e');
    }
  }

  void showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search users...',
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: _searchUsers,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (_searchResults.isEmpty) {
                    return const Center(child: Text('No results found'));
                  }
                  return ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final user = _searchResults[index];
                      return ListTile(
                        leading: CircleAvatar(child: const Icon(Icons.person)),
                        title: Text(user.username),
                        trailing: isGroupChatView.value
                            ? IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  // Handle adding user to group
                                },
                              )
                            : null,
                        onTap: () {
                          if (!isGroupChatView.value) {
                            createPrivateChat(user.id);
                          }
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  void _searchUsers(String query) async {
    // Implement the logic to search for users based on the query
    try {
      _searchResults.value = await _chatService.searchUsers(query);
    } catch (e) {
      print('Error searching users: $e');
    }
  }
}
