import 'package:flutter/material.dart';
import 'package:flutterauth/services/auth/auth_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AuthService authService = AuthService();

  void logout() {
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),
    );
  }
}
