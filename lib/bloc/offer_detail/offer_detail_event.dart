import 'package:equatable/equatable.dart';

abstract class OfferDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetOfferDetail extends OfferDetailEvent {
  final String orderId;

  GetOfferDetail(this.orderId);
}

class PatchOffer extends OfferDetailEvent {
  final String orderId;
  final String status;

  PatchOffer(this.orderId, this.status);
}
