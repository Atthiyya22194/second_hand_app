import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/product_response.dart';

@immutable
abstract class HomePageState extends Equatable {}

class HomePageInitState extends HomePageState {
  @override
  List<Object?> get props => [];
}

class HomePageLoadingState extends HomePageState {
  @override
  List<Object?> get props => [];
}

class HomePageLoadedState extends HomePageState {
  HomePageLoadedState(this.products);

  final List<ProductResponse> products;

  @override
  List<Object?> get props => [products];
}

class HomePageErrorState extends HomePageState {
  HomePageErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}