import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class EditProfileState extends Equatable {}

class EditProfileInitState extends EditProfileState {
  @override
  List<Object?> get props => [];
}

class EditProfileLoadingState extends EditProfileState {
  @override
  List<Object?> get props => [];
}

class EditProfileSuccessState extends EditProfileState {
  EditProfileSuccessState(this.response);
  final String response;

  @override
  List<Object?> get props => [response];
}

class EditProfileErrorState extends EditProfileState {
  EditProfileErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}
