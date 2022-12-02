import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class HomePageEvent extends Equatable {
  const HomePageEvent();
}

class LoadHomePageEvent extends HomePageEvent {
  @override
  List<Object?> get props => [];
  
}
