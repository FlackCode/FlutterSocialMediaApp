import 'package:flutter/material.dart';
import 'package:flutterauth/components/my_button.dart';
import 'package:flutterauth/components/my_textfield.dart';
import 'package:flutterauth/services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) async {
    final AuthService authService = AuthService();

    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    if (passwordController.text == confirmPasswordController.text) {
      Navigator.pop(context);
      if (usernameController.text.isNotEmpty) {
        try {
          await authService.signUpWithEmailAndPassword(emailController.text,
              passwordController.text, usernameController.text);
        } catch (e) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    title: Text(e.toString()),
                  ));
        }
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                title: const Text("Passwords don't match."),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'M I N I M AL',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 50,
                ),
                MyTextfield(
                    hintText: "Username", controller: usernameController),
                const SizedBox(
                  height: 10,
                ),
                MyTextfield(hintText: "Email", controller: emailController),
                const SizedBox(
                  height: 10,
                ),
                MyTextfield(
                  hintText: "Password",
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextfield(
                  hintText: "Confirm Password",
                  controller: confirmPasswordController,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(text: "Register", onTap: () => register(context)),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        "Login Here",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
