import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/product_detail/product_detail_page_events.dart';
import 'package:second_hand_app/bloc/product_detail/product_detail_page_states.dart';
import 'package:second_hand_app/repositories/market_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailBloc
    extends Bloc<ProductDetailPageEvent, ProductDetailPageState> {
  final MarketRepository _repository;

  ProductDetailBloc(this._repository) : super(ProductDetailPageLoadingState()) {
    on<GetData>(_getData);
    on<Order>(_order);
  }

  Future<void> _getData(
      GetData event, Emitter<ProductDetailPageState> emit) async {
    emit(ProductDetailPageLoadingState());
    try {
      final data = await _repository.getDetail(id: event.id);
      emit(ProductDetailPageLoadedState(data));
    } catch (e) {
      emit(ProductDetailPageErrorState(e.toString()));
    }
  }

  Future<void> _order(Order event, Emitter<ProductDetailPageState> emit) async {
    emit(ProductDetailPageLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final data = await _repository.order(
          accessToken: accessToken!,
          productId: event.productId,
          bidPrice: event.bidPrice);
      emit(BidSuccessState(data));
      await _getData(GetData(event.productId), emit);
    } catch (e) {
      emit(BidFailedState(e.toString()));
      await _getData(GetData(event.productId), emit);
    }
  }
}
