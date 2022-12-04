import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Login'),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: 'Email', icon: Icon(CupertinoIcons.mail)),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  labelText: 'Password', icon: Icon(CupertinoIcons.location)),
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Start Bargain"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
