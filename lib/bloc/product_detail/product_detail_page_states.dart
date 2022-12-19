import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/product_detail_response.dart';

@immutable
abstract class ProductDetailPageState extends Equatable {}

class ProductDetailPageInitState extends ProductDetailPageState {
  @override
  List<Object?> get props => [];
}

class ProductDetailPageLoadingState extends ProductDetailPageState {
  @override
  List<Object?> get props => [];
}

class ProductDetailPageLoadedState extends ProductDetailPageState {
  ProductDetailPageLoadedState(this.products);
  final ProductDetailResponse products;

  @override
  List<Object?> get props => [products];
}

class BidSuccessState extends ProductDetailPageState {
  BidSuccessState(this.response);
  final String response;

  @override
  List<Object?> get props => [response];
}

class BidFailedState extends ProductDetailPageState {
  BidFailedState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}

class ProductDetailPageErrorState extends ProductDetailPageState {
  ProductDetailPageErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
