import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProducts extends HomePageEvent {
  final String? productName;
  final String? categoryId;

  GetProducts({ this.productName, this.categoryId});
}
