import 'package:flutter/material.dart';
import 'package:flutterauth/pages/home_page.dart';
import 'package:flutterauth/pages/profile_page.dart';
import 'package:flutterauth/pages/users_page.dart';
import 'package:flutterauth/services/auth/auth_gate.dart';
import 'package:flutterauth/services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(BuildContext context) async {
    final AuthService authService = AuthService();
    await authService.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AuthGate()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Icon(
                Icons.person,
                size: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              )),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text(
                    "HOME",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text(
                    "PROFILE",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePage()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  title: Text(
                    "USERS",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  leading: Icon(
                    Icons.people,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UsersPage()));
                  },
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25, bottom: 25),
                child: ListTile(
                  title: Text(
                    "LOGOUT",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  onTap: () => logout(context),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
