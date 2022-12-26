import 'package:equatable/equatable.dart';

abstract class EditProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUser extends EditProfileEvent {}

class EditProfile extends EditProfileEvent {
  EditProfile(
      {
      required this.fullName,
      required this.phoneNumber,
      required this.address,
      required this.city});

  final String address;
  final String city;
  final String fullName;
  final String phoneNumber;
}

class GetImage extends EditProfileEvent {}
