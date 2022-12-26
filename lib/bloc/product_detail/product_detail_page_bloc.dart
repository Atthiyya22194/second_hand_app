import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/market_repository.dart';
import 'product_detail_page_events.dart';
import 'product_detail_page_states.dart';

class ProductDetailBloc
    extends Bloc<ProductDetailPageEvent, ProductDetailPageState> {
  ProductDetailBloc(this._repository) : super(ProductDetailPageLoadingState()) {
    on<GetData>(_getData);
    on<Order>(_order);
  }

  final MarketRepository _repository;

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
    } catch (e) {
      emit(ProductDetailPageErrorState(e.toString()));
    }
  }
}
