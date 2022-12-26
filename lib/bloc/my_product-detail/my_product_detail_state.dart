import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/product_detail_response.dart';

@immutable
abstract class MyProductDetailState extends Equatable {}

class MyProductDetailInitState extends MyProductDetailState {
  @override
  List<Object?> get props => [];
}

class MyProductDetailLoadingState extends MyProductDetailState {
  @override
  List<Object?> get props => [];
}

class MyProductDetailLoadedState extends MyProductDetailState {
  MyProductDetailLoadedState(this.response);

  final ProductDetailResponse response;

  @override
  List<Object?> get props => [response];
}

class DeleteProductSuccessState extends MyProductDetailState {
  DeleteProductSuccessState(this.response);

  final String response;

  @override
  List<Object?> get props => [response];
}

class MyProductDetailErrorState extends MyProductDetailState {
  MyProductDetailErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
