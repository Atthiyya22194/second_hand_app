import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/login/login_bloc.dart';
import 'package:second_hand_app/bloc/login/login_events.dart';
import 'package:second_hand_app/repositories/auth_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return  BlocProvider(
        create: (context) => LoginBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: Scaffold(
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
                      labelText: 'Password', icon: Icon(CupertinoIcons.lock)),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () => BlocProvider.of<LoginBloc>(context).add(
                        Login(emailController.text, passwordController.text)),
                    child: const Text("Login"),
                  ),
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}
