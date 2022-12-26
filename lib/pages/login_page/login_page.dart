import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../register_page/register_page.dart';
import '../../repositories/auth_repository.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/poppins_text.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_text_field.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_events.dart';
import '../../bloc/login/login_states.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Content(),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: BlocProvider(
              create: (context) => LoginBloc(authRepository: AuthRepository()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(
                          16 * fem, 0 * fem, 0 * fem, 0 * fem),
                      child: const PoppinsText(
                          text: 'Login',
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        16 * fem, 24 * fem, 16 * fem, 24 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        LoginForm(),
                        RegisterButtonText(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  _formValidation<bool>() {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      showSnackBar(context, 'Something went wrong...', 'Please fill all form',
          ContentType.warning);
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 202 * fem),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocConsumer<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginLoadingState) {
                return const ShowLoading();
              }
              return Container();
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
          RoundedTextField(
            hint: 'example@mail.com',
            title: 'Email',
            controller: emailController,
          ),
          RoundedTextField(
            hint: 'Your Password',
            title: 'Password',
            controller: passwordController,
          ),
          SizedBox(
            width: double.infinity,
            child: RoundedButton(
              text: 'Login',
              onPressed: () {
                if (_formValidation() == true) {
                  BlocProvider.of<LoginBloc>(context).add(
                    Login(emailController.text, passwordController.text),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RegisterButtonText extends StatelessWidget {
  const RegisterButtonText({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      margin: EdgeInsets.fromLTRB(45 * fem, 0 * fem, 45 * fem, 0 * fem),
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 4 * fem, 0 * fem),
            child: const PoppinsText(
              text: "Don't have account ?",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                ),
              );
            },
            child: const PoppinsText(
              text: 'Register here',
              color: Color(0xff7126b5),
            ),
          )
        ],
      ),
    );
  }
}
