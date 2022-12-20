import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../models/notification_response.dart';

@immutable
abstract class NotificationState extends Equatable {}

class NotificationInitState extends NotificationState {
  @override
  List<Object?> get props => [];
}

class NotificationLoadingState extends NotificationState {
  @override
  List<Object?> get props => [];
}

class NotificationLoadedState extends NotificationState {
  NotificationLoadedState(this.products);
  final List<NotificationResponse> products;

  @override
  List<Object?> get props => [products];
}

class NotificationErrorState extends NotificationState {
  NotificationErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
