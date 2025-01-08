import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letschat/app/modules/chatTab/model/chat_model.dart';
import 'package:letschat/app/modules/sign_up/model/user_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Chat>> getAllChats(String userId) async {
    try {
      // Get chat document for the specific user ID
      DocumentSnapshot userChatDoc = await _firestore.collection('usersChats').doc(userId).get();
      if (userChatDoc.exists) {
        Map<String, dynamic> data = userChatDoc.data() as Map<String, dynamic>;
        return (data['chats'] as List).map((chat) => Chat.fromMap(chat)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to retrieve chats: $e');
    }
  }

  Future<void> createChat(String userId, Chat chat) async {
    try {
      // Create or update the user's chat document
      DocumentReference userChatRef = _firestore.collection('usersChats').doc(userId).collection(collectionPath).doc().co;
      await userChatRef.set({
        'chats': FieldValue.arrayUnion([chat.toMap()]),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error creating chat: $e');
      throw e;
    }
  }

  Future<List<UserModel>> searchUsers(String query) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: query)
          .where('username', isLessThanOrEqualTo: '$query\uf8ff')
          .get();

      return querySnapshot.docs.map((doc) => UserModel.fromDocument(doc)).toList();
    } catch (e) {
      print('Error searching users: $e');
      return [];
    }
  }

  Future<void> createPrivateChat(String currentUserId, String otherUserId) async {
    try {
      // Create a new Chat object for private chat
      Chat newChat = Chat(
        isGroup: false,
        chatName: 'Chat with $otherUserId',
        profileImage: 'url_to_profile_image', // You can fetch or assign the correct image URL
        lastMessage: Message(
          messageText: '',
          timestamp: Timestamp.now(),
          senderName: currentUserId,
        ),
      );

      // Save the new chat under the current user's document
      await createChat(currentUserId, newChat);

      // Optionally, also save it under the other user's document
      await createChat(otherUserId, newChat);
    } catch (e) {
      print('Error creating private chat: $e');
      throw e;
    }
  }
}
