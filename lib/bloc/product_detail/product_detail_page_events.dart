import 'package:equatable/equatable.dart';

abstract class ProductDetailPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetData extends ProductDetailPageEvent {
  GetData(this.id);

  final String id;
}

class Order extends ProductDetailPageEvent {
  Order(this.productId, this.bidPrice);

  final String bidPrice;
  final String productId;
}

