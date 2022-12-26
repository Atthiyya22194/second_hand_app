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
  MyOrderDetailLoadedState(this.response);

  final OrderResponse response;

  @override
  List<Object?> get props => [response];
}

class PatchBidSuccessState extends MyOrderDetailState {
  PatchBidSuccessState(this.response);

  final String response;

  @override
  List<Object?> get props => [response];
}

class DeleteOrderSuccessState extends MyOrderDetailState {
  DeleteOrderSuccessState(this.response);

  final String response;

  @override
  List<Object?> get props => [response];
}

class MyOrderDetailErrorState extends MyOrderDetailState {
  MyOrderDetailErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
