import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/register/register_bloc.dart';
import '../../bloc/register/register_events.dart';
import '../../bloc/register/register_states.dart';
import '../login_page/login_page.dart';
import '../../repositories/auth_repository.dart';
import '../../widgets/poppins_text.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_text_field.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
              create: (context) => RegisterBloc(
                authRepository: AuthRepository(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(
                          16 * fem, 24 * fem, 0 * fem, 0 * fem),
                      child: const PoppinsText(
                          text: 'Register',
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        16 * fem, 24 * fem, 16 * fem, 24 * fem),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        RegisterForm(),
                        LoginButtonText(),
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

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 24 * fem),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocConsumer<RegisterBloc, RegisterState>(builder: (context, state) {
            if (state is RegisterLoadingState) {
              const ShowLoading();
            }
            return Container();
          }, listener: (context, state) {
            if (state is RegisterSuccessState) {
              showSnackBar(
                  context, 'Sucess', state.response, ContentType.success);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            }
            if (state is RegisterErrorState) {
              showSnackBar(context, 'Something went wrong..', state.error, ContentType.failure);
            }
          }),
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
          RoundedTextField(
            hint: 'Your Name',
            title: 'Full Name',
            controller: fullNameController,
          ),
          RoundedTextField(
            hint: 'Your Phone Number',
            title: 'Phone Number',
            controller: phoneNumberController,
          ),
          RoundedTextField(
            hint: 'Your Address',
            title: 'Address',
            controller: addressController,
          ),
          RoundedTextField(
            hint: 'Your City',
            title: 'Kota',
            controller: cityController,
          ),
          SizedBox(
            width: double.infinity,
            child: RoundedButton(
              text: 'Register',
              onPressed: () {
                if (_formValidation() == true) {
                  BlocProvider.of<RegisterBloc>(context).add(
                    Register(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                      fullName: fullNameController.text.trim(),
                      phoneNumber: phoneNumberController.text.trim(),
                      address: addressController.text.trim(),
                      city: cityController.text.trim(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
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
}

class LoginButtonText extends StatelessWidget {
  const LoginButtonText({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      margin: EdgeInsets.fromLTRB(45 * fem, 0 * fem, 45 * fem, 0 * fem),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 4 * fem, 0 * fem),
            child: const PoppinsText(
              text: "Already have account ?",
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            child: const PoppinsText(
              text: 'Login Here',
              color: Color(0xff7126b5),
            ),
          )
        ],
      ),
    );
  }
}
