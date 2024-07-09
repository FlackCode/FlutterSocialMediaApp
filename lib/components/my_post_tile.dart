import 'package:flutter/material.dart';

class MyPostTile extends StatelessWidget {
  final String message;
  final String email;

  const MyPostTile({super.key, required this.message, required this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 10, right: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(message),
          subtitle: Text(
            email,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ),
    );
  }
}
