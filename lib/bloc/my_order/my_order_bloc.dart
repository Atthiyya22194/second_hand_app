import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/my_order/my_order_event.dart';
import 'package:second_hand_app/bloc/my_order/my_order_state.dart';
import 'package:second_hand_app/repositories/market_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrderBloc extends Bloc<MyOrderEvent, MyOrderState> {
  final MarketRepository _repository;

  MyOrderBloc(this._repository) : super(MyOrderInitState()) {
    on<GetMyOrder>(_getMyOrders);
  }

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
