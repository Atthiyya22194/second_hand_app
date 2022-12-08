import 'package:equatable/equatable.dart';

abstract class HomePageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetNotification extends HomePageEvent {
  final String type;

  GetNotification({required this.type});
}
