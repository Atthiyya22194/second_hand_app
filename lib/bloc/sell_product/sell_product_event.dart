import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class SellProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadProduct extends SellProductEvent {
  final String productName;
  final String description;
  final String basePrice;
  final String category;
  final String location;
  final File image;

  UploadProduct(
      {required this.productName,
      required this.description,
      required this.basePrice,
      required this.category,
      required this.location,
      required this.image});
}

class GetImage extends SellProductEvent {}
