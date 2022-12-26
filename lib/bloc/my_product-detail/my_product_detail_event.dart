import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MyProductDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyProductDetail extends MyProductDetailEvent {
  GetMyProductDetail({required this.id});

  final String id;
}

class DeleteMyProduct extends MyProductDetailEvent {
  DeleteMyProduct({required this.id});

  final String id;
}
