import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.inversePrimary),
        title: Text(
          "Users Page",
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
    );
  }
}
