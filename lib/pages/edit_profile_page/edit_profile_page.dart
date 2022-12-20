import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/edit_profile/edit_profile_bloc.dart';
import '../../bloc/edit_profile/edit_profile_event.dart';
import '../../bloc/edit_profile/edit_profile_state.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';

import '../../repositories/auth_repository.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Edit Profile')),
      body: BlocProvider<EditProfileBloc>(
        create: (context) => EditProfileBloc(AuthRepository()),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('EditProfile'),
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
            onPressed: () {
              BlocProvider.of<EditProfileBloc>(context).add(EditProfile(
                fullName: fullNameController.text,
                phoneNumber: phoneNumberController.text,
                address: addressController.text,
                city: cityController.text,
              ));
            },
            child: const Text("Edit Profile"),
          )
        ],
      ),
    );
  }
}
