import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/pages/login_page/login_page.dart';

import '../../bloc/register/register_bloc.dart';
import '../../bloc/register/register_events.dart';
import '../../bloc/register/register_states.dart';
import '../../repositories/auth_repository.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(authRepository: AuthRepository()),
      child: Center(
        child: Scaffold(
          body: BlocBuilder<RegisterBloc, RegisterState>(
            builder: ((context, state) {
              if (state is RegisterInitState) {
                {
                  return const RegisterForm();
                }
              }
              if (state is RegisterLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is RegisterSuccessState) {
                return const LoginPage();
              }
              if (state is RegisterErrorState) {
                return RegisterForm(
                  errorMessage: state.error,
                );
              }
              return Container();
            }),
          ),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  final String? errorMessage;
  const RegisterForm({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController fullNameController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController cityController = TextEditingController();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Register'),
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
          TextField(
            controller: fullNameController,
            decoration: const InputDecoration(
                labelText: 'Full Name', icon: Icon(CupertinoIcons.person)),
          ),
          TextField(
            controller: phoneNumberController,
            decoration: const InputDecoration(
                labelText: 'Phone Number', icon: Icon(CupertinoIcons.phone)),
          ),
          TextField(
            controller: addressController,
            decoration: const InputDecoration(
                labelText: 'Address', icon: Icon(CupertinoIcons.home)),
          ),
          TextField(
            controller: cityController,
            decoration: const InputDecoration(
                labelText: 'City', icon: Icon(CupertinoIcons.location)),
          ),
          ElevatedButton(
            onPressed: () => BlocProvider.of<RegisterBloc>(context).add(
                Register(
                    email: emailController.text,
                    password: passwordController.text,
                    fullName: fullNameController.text,
                    phoneNumber: phoneNumberController.text,
                    address: addressController.text,
                    city: cityController.text)),
            child: const Text("Register"),
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
