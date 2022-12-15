import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/offer_detail/offer_detail_event.dart';
import 'package:second_hand_app/bloc/offer_detail/offer_detail_state.dart';
import 'package:second_hand_app/repositories/market_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfferDetailBloc extends Bloc<OfferDetailEvent, OfferDetailState> {
  final MarketRepository _repository;

  OfferDetailBloc(this._repository) : super(OfferDetailInitState()) {
    on<GetOfferDetail>(_getOfferDetail);
    on<PatchOffer>(_patchOffer);
  }

  Future<void> _getOfferDetail(
      GetOfferDetail event, Emitter<OfferDetailState> emit) async {
    emit(OfferDetailLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final data = await _repository.getOfferedDetail(
          accessToken: accessToken!, orderId: event.orderId);
      emit(OfferDetailLoadedState(data));
    } catch (e) {
      emit(OfferDetailErrorState(e.toString()));
    }
  }

  Future<void> _patchOffer(
      PatchOffer event, Emitter<OfferDetailState> emit) async {
    emit(OfferDetailLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final data = await _repository.patchOffered(
          accessToken: accessToken!,
          orderId: event.orderId,
          status: event.status);
      emit(PatchSuccessState(data));
    } catch (e) {
      emit(OfferDetailErrorState(e.toString()));
    }
  }
}
