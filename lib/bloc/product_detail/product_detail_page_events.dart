import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ProductDetailPageEvent extends Equatable {
  const ProductDetailPageEvent();
}

class LoadProductDetailPageEvent extends ProductDetailPageEvent {
  @override
  List<Object?> get props => [];
  
}
