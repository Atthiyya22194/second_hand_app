import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProducts extends HomePageEvent {
  GetProducts({ this.productName, this.categoryId});

  final String? categoryId;
  final String? productName;
}
