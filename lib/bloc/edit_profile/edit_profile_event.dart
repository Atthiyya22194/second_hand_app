import 'package:equatable/equatable.dart';

abstract class EditProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetUser extends EditProfileEvent {}

class EditProfile extends EditProfileEvent {
  final String fullName;
  final String phoneNumber;
  final String address;
  final String city;

  EditProfile(
      {
      required this.fullName,
      required this.phoneNumber,
      required this.address,
      required this.city});
}

class GetImage extends EditProfileEvent {}
