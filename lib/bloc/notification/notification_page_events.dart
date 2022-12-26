import 'package:equatable/equatable.dart';

abstract class NotificationPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetNotification extends NotificationPageEvent {
  GetNotification({required this.type});

  final String type;
}
