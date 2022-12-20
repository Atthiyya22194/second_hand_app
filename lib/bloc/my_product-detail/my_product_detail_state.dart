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
  final ProductDetailResponse response;

  MyProductDetailLoadedState(this.response);
  @override
  List<Object?> get props => [response];
}

class DeleteProductSuccessState extends MyProductDetailState {
  final String response;

  DeleteProductSuccessState(this.response);
  @override
  List<Object?> get props => [response];
}

class MyProductDetailErrorState extends MyProductDetailState {
  final String error;

  MyProductDetailErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
