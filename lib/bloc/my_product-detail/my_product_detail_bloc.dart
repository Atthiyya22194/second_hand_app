import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/market_repository.dart';
import 'my_product_detail_event.dart';
import 'my_product_detail_state.dart';

class MyProductDetailBloc extends Bloc<MyProductDetailEvent, MyProductDetailState> {
  MyProductDetailBloc(this._repository) : super(MyProductDetailInitState()) {
    on<GetMyProductDetail>(_getMyProductDetail);
  }

  final MarketRepository _repository;

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
}
