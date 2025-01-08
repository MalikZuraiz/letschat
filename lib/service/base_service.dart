import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseService<T> {
  final CollectionReference<Map<String, dynamic>> ref;

  // The `fromDocument` function will be provided by subclasses to convert Firestore data to Dart objects
  final T Function(DocumentSnapshot<Map<String, dynamic>> doc) fromDocument;

  BaseService({
    required this.ref,
    required this.fromDocument,
  });

  Future<void> addDocument(T data, String id) async {
    await ref.doc(id).set((data as dynamic).toMap(), SetOptions(merge: true));
  }

  Future<void> updateDocument(String id, T data) async {
    await ref.doc(id).set((data as dynamic).toMap(), SetOptions(merge: true));
  }

  Future<void> deleteDocument(String id) async {
    await ref.doc(id).delete();
  }

  Stream<List<T>> getDocuments() {
    return ref
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => fromDocument(doc)).toList());
  }

  Future<T?> getDocumentById(String id) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await ref.doc(id).get();
    return doc.exists ? fromDocument(doc) : null;
  }
}
