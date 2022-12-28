import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class EditProductState extends Equatable {}

class EditProductInitState extends EditProductState {
  @override
  List<Object?> get props => [];
}

class EditProductLoadingState extends EditProductState {
  @override
  List<Object?> get props => [];
}

class EditProductSuccessState extends EditProductState {
  EditProductSuccessState(this.response);

  final String response;

  @override
  List<Object?> get props => [response];
}

class LoadImageState extends EditProductState {
  LoadImageState(this.image);

  final File image;

  @override
  List<Object?> get props => [image];
}

class EditProductErrorState extends EditProductState {
  EditProductErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
