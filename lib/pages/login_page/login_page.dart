import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/login/login_bloc.dart';
import 'package:second_hand_app/bloc/login/login_events.dart';
import 'package:second_hand_app/pages/register_page/register_page.dart';
import 'package:second_hand_app/widgets/bottom_nav_bar.dart';
import 'package:second_hand_app/widgets/show_loading.dart';
import 'package:second_hand_app/widgets/show_snack_bar.dart';

import '../../bloc/login/login_states.dart';
import '../../repositories/auth_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(authRepository: AuthRepository()),
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginLoadingState) {
              return const ShowLoading();
            }
            return const LoginForm();
          },
          listener: (context, state) {
            if (state is LoginSuccessState) {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(builder: (context) => const BottomNavBar()),
              );
            }
            if (state is LoginErrorState) {
              showSnackBar(
                  context, "Login Failed!", state.error, ContentType.failure);
            }
          },
        ),
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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => BlocProvider.of<LoginBloc>(context)
                    .add(Login(emailController.text, passwordController.text)),
                child: const Text("Login"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage())),
                child: const Text("Create accout"),
              ),
            ],
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
      ),
    );
  }
}
