import 'package:flutter/material.dart';
import 'package:flutterauth/components/my_drawer.dart';
import 'package:flutterauth/components/my_post_button.dart';
import 'package:flutterauth/components/my_post_tile.dart';
import 'package:flutterauth/components/my_textfield.dart';
import 'package:flutterauth/services/firestore/firestore_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final TextEditingController postController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

  void addPost(String message) async {
    if (postController.text.isNotEmpty) {
      try {
        await firestoreService.addPost(message);
        postController.clear();
      } catch (e) {
        print(e.toString());
      }
    } else {
      print("Post Controller Empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        //iconTheme:
        //    IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
        title: Text(
          "Home",
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: MyTextfield(
                      hintText: "Say something", controller: postController),
                ),
                MyPostButton(onTap: () => addPost(postController.text))
              ],
            ),
          ),
          StreamBuilder(
              stream: firestoreService.getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final posts = snapshot.data!.docs;

                  return Expanded(
                    child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];

                          return MyPostTile(
                              message: post["message"], email: post["email"]);
                        }),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Center(
                    child: Text("Error fetching posts"),
                  );
                }
              })
        ],
      ),
    );
  }
}
