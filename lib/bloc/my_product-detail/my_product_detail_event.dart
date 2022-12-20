import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class MyProductDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetMyProductDetail extends MyProductDetailEvent {
  final String id;

  GetMyProductDetail({required this.id});
}

class DeleteMyProduct extends MyProductDetailEvent {
  final String id;

  DeleteMyProduct({required this.id});
}
