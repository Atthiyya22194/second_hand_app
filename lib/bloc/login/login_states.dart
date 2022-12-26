import 'package:equatable/equatable.dart';

import '../../models/login_response.dart';

abstract class LoginState extends Equatable {}

class LoginInitState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccessState extends LoginState {
  LoginSuccessState(this._loginResponse);

  final LoginResponse _loginResponse;

  @override
  List<Object?> get props => [_loginResponse];
}

class LoginErrorState extends LoginState {
  LoginErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
