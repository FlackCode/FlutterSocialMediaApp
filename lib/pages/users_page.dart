import 'package:flutter/material.dart';
import 'package:flutterauth/components/my_back_button.dart';
import 'package:flutterauth/components/my_post_tile.dart';
import 'package:flutterauth/services/firestore/firestore_service.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key});

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  elevation: 0.0,
      //  backgroundColor: Theme.of(context).colorScheme.primary,
      //  iconTheme:
      //      IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
      //  title: Text(
      //    "Users Page",
      //    style: TextStyle(
      //        color: Theme.of(context).colorScheme.inversePrimary,
      //        fontWeight: FontWeight.w500),
      //  ),
      //  centerTitle: true,
      //),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: StreamBuilder(
          stream: firestoreService.getUsersStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data!.docs;

              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 50, left: 25, bottom: 25),
                    child: Row(
                      children: [
                        MyBackButton(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final user = users[index];

                          return MyPostTile(
                              message: user["username"], email: user["email"]);
                        }),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text("Error Loading Data"),
              );
            }
          }),
    );
  }
}
