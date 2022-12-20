import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MyOrderDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyOrderDetail extends MyOrderDetailEvent {
  final String id;

  GetMyOrderDetail({required this.id});
}

class PutMyBidPrice extends MyOrderDetailEvent {
  final String id;
  final String bidPrice;

  PutMyBidPrice({required this.id, required this.bidPrice});
}

class DeleteMyOrder extends MyOrderDetailEvent {
  final String id;

  DeleteMyOrder({required this.id});
}
