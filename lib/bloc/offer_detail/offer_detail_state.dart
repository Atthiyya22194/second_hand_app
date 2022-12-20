import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/order_response.dart';

@immutable
abstract class OfferDetailState extends Equatable {}

class OfferDetailInitState extends OfferDetailState {
  @override
  List<Object?> get props => [];
}

class OfferDetailLoadingState extends OfferDetailState {
  @override
  List<Object?> get props => [];
}

class PatchSuccessState extends OfferDetailState {
  final String message;

  PatchSuccessState(this.message);
  @override
  List<Object?> get props => [message];
}

class WhatAppLaunchedState extends OfferDetailState {
  WhatAppLaunchedState(this.launch);
  final bool launch;

  @override
  List<Object?> get props => [launch];
}

class OfferDetailErrorState extends OfferDetailState {
  final String error;

  OfferDetailErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class OfferDetailLoadedState extends OfferDetailState {
  final OrderResponse order;

  OfferDetailLoadedState(this.order);
  @override
  List<Object?> get props => [order];
}
