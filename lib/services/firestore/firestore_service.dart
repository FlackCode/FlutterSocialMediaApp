import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails(
      String userID) async {
    return await _firestore.collection("users").doc(userID).get();
  }
}
