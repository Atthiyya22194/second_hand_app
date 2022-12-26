import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/order_response.dart';

@immutable
abstract class MyOrderDetailState extends Equatable {}

class MyOrderDetailInitState extends MyOrderDetailState {
  @override
  List<Object?> get props => [];
}

class MyOrderDetailLoadingState extends MyOrderDetailState {
  @override
  List<Object?> get props => [];
}

class MyOrderDetailLoadedState extends MyOrderDetailState {
  final OrderResponse response;

  MyOrderDetailLoadedState(this.response);
  @override
  List<Object?> get props => [response];
}

class PatchBidSuccessState extends MyOrderDetailState {
  final String response;

  PatchBidSuccessState(this.response);
  @override
  List<Object?> get props => [response];
}

class DeleteOrderSuccessState extends MyOrderDetailState {
  final String response;

  DeleteOrderSuccessState(this.response);
  @override
  List<Object?> get props => [response];
}

class MyOrderDetailErrorState extends MyOrderDetailState {
  final String error;

  MyOrderDetailErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
