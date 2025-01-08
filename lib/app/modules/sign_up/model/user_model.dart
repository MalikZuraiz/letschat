import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id; 
  String username; 
  String email; 
  DateTime createdDate; 
  List<String>? devices; 
  String signInMethod; 
  DateTime dateOfBirth; 
  String bio; 
  String phoneNumber; 
  String profileImageUrl; 
  bool isOnline; 
  DateTime lastSeen; 
  List<String> friends; 
  List<String> interests; 

  List<String> connectionRequests; 
  List<String> pendingRequests; 

  bool allowDirectMessagesFromNonFriends; 
  bool allowNonFriendsToSeePosts; 
  
  bool? notificationsEnabled; 
  String theme; 

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.createdDate,
    this.devices,
    required this.signInMethod,
    required this.dateOfBirth,
    required this.bio,
    required this.phoneNumber,
    required this.profileImageUrl,
    this.isOnline = false,
    required this.lastSeen,
    required this.friends,
    required this.interests,
    required this.connectionRequests,
    required this.pendingRequests,
    this.allowDirectMessagesFromNonFriends = true,
    this.allowNonFriendsToSeePosts = true,
    this.notificationsEnabled = true,
    this.theme = 'light',
  });

  // Convert Firestore document to UserModel
  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    return UserModel(
      id: doc.id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      createdDate: (data['createdDate'] as Timestamp).toDate(),
      devices: List<String>.from(data['devices'] ?? []),
      signInMethod: data['signInMethod'] ?? '',
      dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
      bio: data['bio'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      isOnline: data['isOnline'] ?? false,
      lastSeen: (data['lastSeen'] as Timestamp).toDate(),
      friends: List<String>.from(data['friends'] ?? []),
      interests: List<String>.from(data['interests'] ?? []),
      connectionRequests: List<String>.from(data['connectionRequests'] ?? []),
      pendingRequests: List<String>.from(data['pendingRequests'] ?? []),
      allowDirectMessagesFromNonFriends: data['allowDirectMessagesFromNonFriends'] ?? true,
      allowNonFriendsToSeePosts: data['allowNonFriendsToSeePosts'] ?? true,
      notificationsEnabled: data['notificationsEnabled'] ?? true,
      theme: data['theme'] ?? 'light',
    );
  }

  // Convert UserModel to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'createdDate': Timestamp.fromDate(createdDate),
      'devices': devices,
      'signInMethod': signInMethod,
      'dateOfBirth': Timestamp.fromDate(dateOfBirth),
      'bio': bio,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'isOnline': isOnline,
      'lastSeen': Timestamp.fromDate(lastSeen),
      'friends': friends,
      'interests': interests,
      'connectionRequests': connectionRequests,
      'pendingRequests': pendingRequests,
      'allowDirectMessagesFromNonFriends': allowDirectMessagesFromNonFriends,
      'allowNonFriendsToSeePosts': allowNonFriendsToSeePosts,
      'notificationsEnabled': notificationsEnabled,
      'theme': theme,
    };
  }
}
