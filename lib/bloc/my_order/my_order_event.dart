import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MyOrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyOrder extends MyOrderEvent {}
