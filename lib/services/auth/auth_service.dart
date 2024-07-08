import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailAndPassword(
      String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw Exception("Error Logging in!");
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, password, username) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        'username': username,
        'email': email,
        'uid': userCredential.user!.uid
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw Exception("Failed to register");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
