import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class EditProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EditProduct extends EditProductEvent {
  EditProduct(
      {required this.productId,
      required this.productName,
      required this.description,
      required this.basePrice,
      required this.category,
      required this.location,
      required this.image});

  final String productId;
  final String basePrice;
  final String category;
  final String description;
  final File? image;
  final String location;
  final String productName;
}

class GetImage extends EditProductEvent {}
