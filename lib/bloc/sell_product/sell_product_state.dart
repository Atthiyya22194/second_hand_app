import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class SellProductState extends Equatable {}

class SellProductInitState extends SellProductState {
  @override
  List<Object?> get props => [];
}

class SellProductLoadingState extends SellProductState {
  @override
  List<Object?> get props => [];
}

class SellProductSuccessState extends SellProductState {
  SellProductSuccessState(this.response);

  final String response;

  @override
  List<Object?> get props => [response];
}

class LoadImageState extends SellProductState {
  LoadImageState(this.image);

  final File image;

  @override
  List<Object?> get props => [image];
}

class SellProductErrorState extends SellProductState {
  SellProductErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
