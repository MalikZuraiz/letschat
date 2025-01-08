import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_tab_controller.dart';

class ChatTabView extends GetView<ChatTabController> {
  const ChatTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => Text(
                    controller.isGroupChatView.value ? 'Group Chats' : 'Private Chats',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Obx(
                  () => IconButton(
                    icon: Icon(controller.isGroupChatView.value ? Icons.group : Icons.person),
                    onPressed: controller.toggleChatView,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(
                () => controller.isGroupChatView.value
                    ? _buildGroupChatGrid()
                    : _buildPrivateChatList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.showSearchBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPrivateChatList() {
    return Obx(() {
      if (controller.privateChats.isEmpty) {
        return const Center(child: Text('No private chats available'));
      }
      return ListView.builder(
        itemCount: controller.privateChats.length,
        itemBuilder: (context, index) {
          final chat = controller.privateChats[index];
          return Dismissible(
            key: Key('private_chat_${chat.chatName}'),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              return await _showDeleteConfirmationDialog(context);
            },
            background: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Icon(Icons.delete, color: Colors.red),
            ),
            child: ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(chat.profileImage)),
              title: Text(chat.chatName),
              subtitle: Text(chat.lastMessage.messageText),
              trailing: Text(
                '${chat.lastMessage.timestamp.toDate().toLocal()}',
                style: const TextStyle(color: Colors.grey),
              ),
              onTap: () {
                // Navigate to the chat screen for this private chat
              },
            ),
          );
        },
      );
    });
  }

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Delete Chat"),
        content: const Text("Are you sure you want to delete this chat?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Delete"),
          ),
        ],
      );
    });
  }

  Widget _buildGroupChatGrid() {
    return Obx(() {
      if (controller.groupChats.isEmpty) {
        return const Center(child: Text('No group chats available'));
      }
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: controller.groupChats.length,
        itemBuilder: (context, index) {
          final chat = controller.groupChats[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the chat screen for this group chat
            },
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          child: const Icon(Icons.group),
                          radius: 25,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          chat.chatName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          chat.lastMessage.messageText,
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 1,
                      child: Text(
                        '${chat.lastMessage.timestamp.toDate().toLocal()}',
                        style: const TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
