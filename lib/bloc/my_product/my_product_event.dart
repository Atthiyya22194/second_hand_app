import 'package:equatable/equatable.dart';

abstract class MyProductPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetMyProduct extends MyProductPageEvent {}

class GetOfferedProduct extends MyProductPageEvent {
  GetOfferedProduct(this.status);

  final String status;
}
