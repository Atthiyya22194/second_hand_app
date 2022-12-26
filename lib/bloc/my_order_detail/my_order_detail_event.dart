import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MyOrderDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyOrderDetail extends MyOrderDetailEvent {
  GetMyOrderDetail({required this.id});

  final String id;
}

class PutMyBidPrice extends MyOrderDetailEvent {
  PutMyBidPrice({required this.id, required this.bidPrice});

  final String bidPrice;
  final String id;
}

class DeleteMyOrder extends MyOrderDetailEvent {
  DeleteMyOrder({required this.id});

  final String id;
}
