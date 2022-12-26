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
  PatchSuccessState(this.message);

  final String message;

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
  OfferDetailErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}

class OfferDetailLoadedState extends OfferDetailState {
  OfferDetailLoadedState(this.order);

  final OrderResponse order;

  @override
  List<Object?> get props => [order];
}
