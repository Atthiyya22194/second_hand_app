import 'package:equatable/equatable.dart';

abstract class OfferDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetOfferDetail extends OfferDetailEvent {
  GetOfferDetail(this.orderId);

  final String orderId;
}

class PatchOffer extends OfferDetailEvent {
  PatchOffer(this.orderId, this.status);

  final String orderId;
  final String status;
}

class OpenWhatsApp extends OfferDetailEvent {
  OpenWhatsApp(this.phoneNumber, this.message);

  final String message;
  final String phoneNumber;
}
