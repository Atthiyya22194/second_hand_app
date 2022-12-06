import 'package:equatable/equatable.dart';

abstract class ProductDetailPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetData extends ProductDetailPageEvent {
  final String id;

  GetData(this.id);
}

class Order extends ProductDetailPageEvent {
  final String productId;
  final String bidPrice;

  Order(this.productId, this.bidPrice);
}

