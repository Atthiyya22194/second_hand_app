import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/login/login_events.dart';
import 'package:second_hand_app/bloc/login/login_states.dart';
import 'package:second_hand_app/repositories/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitState()) {
    on<Login>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final result = await authRepository.getProducts(
            email: event.email, password: event.password);
        emit(LoginSuccessState(result));
      } catch (e) {
        emit(LoginErrorState(e.toString()));
      }
    });
  }
}
