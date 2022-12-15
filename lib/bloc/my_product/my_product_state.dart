import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class MyProductState extends Equatable {}

class MyProductInitState extends MyProductState {
  @override
  List<Object?> get props => [];
}

class MyProductLoadingState extends MyProductState {
  @override
  List<Object?> get props => [];
}

class MyProductLoadedState extends MyProductState {
  MyProductLoadedState(this.products);
  final dynamic products;

  @override
  List<Object?> get props => [products];
}

class MyProductErrorState extends MyProductState {
  MyProductErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}