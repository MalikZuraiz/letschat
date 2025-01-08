import 'package:cloud_firestore/cloud_firestore.dart';

// Model for individual messages
class Message {
  String messageText;
  Timestamp timestamp;
  String senderName;

  Message({
    required this.messageText,
    required this.timestamp,
    required this.senderName,
  });

  // Convert a Message to a Map
  Map<String, dynamic> toMap() {
    return {
      'messageText': messageText,
      'timestamp': timestamp,
      'senderName': senderName,
    };
  }

  // Create a Message from a Map
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageText: map['messageText'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
      senderName: map['senderName'] ?? '',
    );
  }
}

// Model for a chat
class Chat {
  bool isGroup;
  String chatName;
  String profileImage;
  Message lastMessage;

  Chat({
    required this.isGroup,
    required this.chatName,
    required this.profileImage,
    required this.lastMessage,
  });

  // Convert a Chat to a Map
  Map<String, dynamic> toMap() {
    return {
      'isGroup': isGroup,
      'lastMessage': lastMessage.toMap(),
      'chatInfo': {
        'chatName': chatName,
        'profileImage': profileImage,
      },
    };
  }

  // Create a Chat from a Map
  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      isGroup: map['isGroup'] ?? false,
      chatName: map['chatInfo']['chatName'] ?? '',
      profileImage: map['chatInfo']['profileImage'] ?? '',
      lastMessage: Message.fromMap(map['lastMessage']),
    );
  }
}

// Model for a user with a list of chats
class UserChats {
  String userId;
  List<Chat> chats;

  UserChats({
    required this.userId,
    required this.chats,
  });

  // Convert UserChats to a Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'chats': chats.map((chat) => chat.toMap()).toList(),
    };
  }

  // Create UserChats from a Map
  factory UserChats.fromMap(Map<String, dynamic> map) {
    return UserChats(
      userId: map['userId'] ?? '',
      chats: List<Chat>.from(
        map['chats'].map((chatMap) => Chat.fromMap(chatMap)),
      ),
    );
  }
}
