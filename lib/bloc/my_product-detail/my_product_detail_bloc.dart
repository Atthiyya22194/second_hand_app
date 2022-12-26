import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/market_repository.dart';
import 'my_product_detail_event.dart';
import 'my_product_detail_state.dart';

class MyProductDetailBloc extends Bloc<MyProductDetailEvent, MyProductDetailState> {
  final MarketRepository _repository;
  MyProductDetailBloc(this._repository) : super(MyProductDetailInitState()) {
    on<GetMyProductDetail>(_getMyProductDetail);
    on<DeleteMyProduct>(_deleteMyMyProductDetail);
  }

  Future<void> _getMyProductDetail(
      GetMyProductDetail event, Emitter<MyProductDetailState> emit) async {
    emit(MyProductDetailLoadingState());
    try {
      final data = await _repository.getDetail( id: event.id);
      emit(MyProductDetailLoadedState(data));
    } catch (e) {
      emit(MyProductDetailErrorState(e.toString()));
    }
  }

  Future<void> _deleteMyMyProductDetail(
      DeleteMyProduct event, Emitter<MyProductDetailState> emit) async {
    emit(MyProductDetailLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final data = await _repository.deleteMyProduct(
          accessToken: accessToken!, productId: event.id);
      emit(DeleteProductSuccessState(data));
    } catch (e) {
      emit(MyProductDetailErrorState(e.toString()));
    }
  }
}
