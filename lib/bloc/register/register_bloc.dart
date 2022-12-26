import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/auth_repository.dart';
import 'register_events.dart';
import 'register_states.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
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

  final AuthRepository authRepository;
}
