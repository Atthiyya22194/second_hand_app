import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/register/register_events.dart';
import 'package:second_hand_app/bloc/register/register_states.dart';
import 'package:second_hand_app/repositories/auth_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterInitState()) {
    on<Register>((event, emit) async {
      emit(RegisterLoadingState());
      try {
        final result = await authRepository.register(
            email: event.email,
            password: event.password,
            phoneNumber: event.phoneNumber,
            fullName: event.fullName,
            address: event.address,
            city: event.city);
        emit(RegisterSuccessState(result));
      } catch (e) {
        emit(RegisterErrorState(e.toString()));
      }
    });
  }
}
