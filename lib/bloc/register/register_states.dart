import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {}

class RegisterInitState extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterLoadingState extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterSuccessState extends RegisterState {
  RegisterSuccessState(this._response);
  final String _response;

  @override
  List<Object?> get props => [_response];
}

class RegisterErrorState extends RegisterState {
  RegisterErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}
