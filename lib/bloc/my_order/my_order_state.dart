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
  final List<OrderResponse> response;

  MyOrderLoadedState(this.response);
  @override
  List<Object?> get props => [response];
}

class MyOrderErrorState extends MyOrderState {
  final String error;

  MyOrderErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
