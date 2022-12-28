import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/order_response.dart';

@immutable
abstract class MyOrderState extends Equatable {}

class MyOrderInitState extends MyOrderState {
  @override
  List<Object?> get props => [];
}

class MyOrderLoadingState extends MyOrderState {
  @override
  List<Object?> get props => [];
}

class MyOrderLoadedState extends MyOrderState {
  MyOrderLoadedState(this.response);

  final List<OrderResponse> response;

  @override
  List<Object?> get props => [response];
}

class MyOrderErrorState extends MyOrderState {
  MyOrderErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
