import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/login/login_bloc.dart';
import 'package:second_hand_app/bloc/login/login_events.dart';
import 'package:second_hand_app/widgets/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/login/login_states.dart';

accessToken() async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');
  return accessToken;
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: ((context, state) {
          if (state is LoginInitState) {
            if (accessToken() != null) {
              return const BottomNavBar();
            } else {
              return const LoginForm();
            }
            ;
          }
          if (state is LoginLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoginSuccessState) {
            return const BottomNavBar();
          }
          if (state is LoginErrorState) {
            return LoginForm(
              errorMessage: state.error,
            );
          }

          return Container();
        }),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final String? errorMessage;
  const LoginForm({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
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
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () => BlocProvider.of<LoginBloc>(context)
                .add(Login(emailController.text, passwordController.text)),
            child: const Text("Login"),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage ?? "",
              style: const TextStyle(color: CupertinoColors.destructiveRed),
            )
          ],
        )
      ],
    );
  }
}
