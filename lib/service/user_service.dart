import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:letschat/app/modules/sign_up/model/user_model.dart';
import 'package:letschat/config/app_const.dart';
import 'package:letschat/service/base_service.dart';

class UserService extends BaseService<UserModel> {
  UserService()
      : super(
          ref: FirebaseFirestore.instance
              .collection(CollectionKey.USERS)
              .withConverter<UserModel>(
                fromFirestore: (snapshot, _) =>
                    UserModel.fromFirestore(snapshot),
                toFirestore: (user, _) => user.toMap(),
              ),
        );

  // Create user in Firestore
  Future<void> createUser(UserModel userModel) async {
    await addDocument(userModel, userModel.id!);
  }

  // Get user by ID from Firestore
  Future<UserModel?> getUserById(String id) async {
    return await getDocumentById(id);
  }

  // Update user data in Firestore
  Future<void> updateUser(UserModel userModel) async {
    await updateDocument(userModel.id!, userModel);
  }

  // Delete user from Firestore
  Future<void> deleteUser(String id) async {
    await deleteDocument(id);
  }

  // Stream user list from Firestore
  Stream<List<UserModel>> streamUsers() {
    return getDocuments();
  }
}
