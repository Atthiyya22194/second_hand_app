import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/market_repository.dart';
import 'my_order_event.dart';
import 'my_order_state.dart';

class MyOrderBloc extends Bloc<MyOrderEvent, MyOrderState> {
  MyOrderBloc(this._repository) : super(MyOrderInitState()) {
    on<GetMyOrder>(_getMyOrders);
  }

  final MarketRepository _repository;

  Future<void> _getMyOrders(
      GetMyOrder event, Emitter<MyOrderState> emit) async {
    emit(MyOrderLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final data = await _repository.getMyOrders(accessToken: accessToken!);
      emit(MyOrderLoadedState(data));
    } catch (e) {
      emit(MyOrderErrorState(e.toString()));
    }
  }
}
