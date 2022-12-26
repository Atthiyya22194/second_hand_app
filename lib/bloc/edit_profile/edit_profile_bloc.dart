import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/auth_repository.dart';
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(this._repository) : super(EditProfileInitState()) {
    on<EditProfile>(_editProfile);
  }

  final AuthRepository _repository;

  Future<void> _editProfile(
      EditProfile event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final response = await _repository.editProfile(
          accessToken: accessToken!,
          fullName: event.fullName,
          phoneNumber: event.phoneNumber,
          address: event.address,
          city: event.city,
          );
      emit(EditProfileSuccessState(response));
    } catch (e) {
      emit(EditProfileErrorState(e.toString()));
    }
  }
}
