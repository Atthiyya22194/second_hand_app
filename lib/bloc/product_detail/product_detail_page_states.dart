import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:second_hand_app/models/product_detail_response.dart';

@immutable
abstract class ProductDetailPageState extends Equatable {}

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

class ProductDetailPageErrorState extends ProductDetailPageState {
  ProductDetailPageErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
