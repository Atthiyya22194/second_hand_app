import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/widgets/rounded_button.dart';
import 'package:second_hand_app/widgets/rounded_text_field.dart';
import '../../bloc/edit_profile/edit_profile_bloc.dart';
import '../../bloc/edit_profile/edit_profile_event.dart';
import '../../bloc/edit_profile/edit_profile_state.dart';
import '../../widgets/poppins_text.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';

import '../../repositories/auth_repository.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      body: BlocProvider<EditProfileBloc>(
        create: (context) => EditProfileBloc(AuthRepository()),
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(24 * fem, 16 * fem, 24 * fem, 8 * fem),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const PoppinsText(
                  text: 'Edit Profile',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                BlocConsumer<EditProfileBloc, EditProfileState>(
                  builder: (context, state) {
                    if (state is EditProfileLoadingState) {
                      const ShowLoading();
                    }
                    return Container();
                  },
                  listener: (context, state) {
                    if (state is EditProfileSuccessState) {
                      showSnackBar(context, 'Succesfully Updated',
                          state.response, ContentType.success);
                    }
                    if (state is EditProfileErrorState) {
                      showSnackBar(context, 'Something went wrong...',
                          state.error, ContentType.failure);
                    }
                  },
                ),
                const EditProfileForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditProfileForm extends StatefulWidget {
  final String? errorMessage;
  const EditProfileForm({super.key, this.errorMessage});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
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
      padding: EdgeInsets.fromLTRB(0, 24 * fem, 0, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedTextField(
            hint: 'John Doe',
            title: 'Full Name',
            controller: fullNameController,
          ),
          RoundedTextField(
            hint: 'Your phone number',
            title: 'Phone Number',
            controller: phoneNumberController,
          ),
          RoundedTextField(
            hint: 'Your address',
            title: 'Address',
            controller: addressController,
          ),
          RoundedTextField(
            hint: 'Your City',
            title: 'City',
            controller: cityController,
          ),
          SizedBox(
            width: double.infinity,
            child: RoundedButton(
              onPressed: () {
                BlocProvider.of<EditProfileBloc>(context).add(
                  EditProfile(
                    fullName: fullNameController.text,
                    phoneNumber: phoneNumberController.text,
                    address: addressController.text,
                    city: cityController.text,
                  ),
                );
              },
              text: "Edit Profile",
            ),
          )
        ],
      ),
    );
  }
}
