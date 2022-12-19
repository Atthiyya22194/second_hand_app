import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/auth_repository.dart';
import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitState()) {
    on<Login>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final result = await authRepository.login(
            email: event.email, password: event.password);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('accessToken', result.accessToken);
        emit(LoginSuccessState(result));
      } catch (e) {
        emit(LoginErrorState(e.toString()));
      }
    });
  }
}
