import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterauth/services/auth/auth_service.dart';
import 'package:flutterauth/services/firestore/firestore_service.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final AuthService authService = AuthService();
  final FirestoreService firestoreService = FirestoreService();

  User? getUser() {
    User? currentUser = authService.getCurrentUser();
    return currentUser;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDetails() async {
    User? user = authService.getCurrentUser();
    if (user != null) {
      return await firestoreService.getUserDetails(user.uid);
    } else {
      throw Exception("User not logged in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
        title: Text(
          "Profile Page",
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic>? user = snapshot.data!.data();
              return Column(
                children: [Text(user!["email"]), Text(user["username"])],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error loading data...",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              );
            } else {
              return Center(
                child: Text(
                  "Error loading data...",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              );
            }
          }),
    );
  }
}
