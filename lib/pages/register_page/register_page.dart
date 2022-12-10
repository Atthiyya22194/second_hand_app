import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/pages/login_page/login_page.dart';
import 'package:second_hand_app/widgets/show_loading.dart';

import '../../bloc/register/register_bloc.dart';
import '../../bloc/register/register_events.dart';
import '../../bloc/register/register_states.dart';
import '../../repositories/auth_repository.dart';
import '../../widgets/show_snack_bar.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(authRepository: AuthRepository()),
      child: Scaffold(
        body: BlocConsumer<RegisterBloc, RegisterState>(
          builder: (context, state) {
            if (state is RegisterLoadingState) {
              return const ShowLoading();
            }
            return const RegisterForm();
          },
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              showSnackBar(context, "Successfully Register!",
                  "You have register successfully", ContentType.success);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }
            if (state is RegisterErrorState) {
              showSnackBar(context, "Register Failed!", state.error,
                  ContentType.failure);
            }
          },
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                ),
                child: const Text("To login page"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
