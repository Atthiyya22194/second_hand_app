import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Register extends RegisterEvent {
  Register({required this.email, required this.password, required this.fullName, required this.phoneNumber,
      required this.address, required this.city});

  final String address;
  final String city;
  final String email;
  final String fullName;
  final String password;
  final String phoneNumber;
}
