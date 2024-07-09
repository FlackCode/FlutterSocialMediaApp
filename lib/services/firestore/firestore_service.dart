import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterauth/services/auth/auth_service.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("posts");
  User? user = AuthService().getCurrentUser();

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("users").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPostsStream() {
    return _firestore.collection("posts").orderBy("timestamp", descending: true).snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails(
      String userID) async {
    return await _firestore.collection("users").doc(userID).get();
  }

  Future<void> addPost(String message) {
    return posts.add({
      "message": message,
      "email": user!.email,
      "timestamp": Timestamp.now()
    });
  }
}
