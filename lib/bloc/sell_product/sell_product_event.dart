import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class SellProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UploadProduct extends SellProductEvent {
  UploadProduct(
      {required this.productName,
      required this.description,
      required this.basePrice,
      required this.category,
      required this.location,
      required this.image});

  final String basePrice;
  final String category;
  final String description;
  final File image;
  final String location;
  final String productName;
}

class GetImage extends SellProductEvent {}
