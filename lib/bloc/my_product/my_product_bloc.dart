import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/my_product/my_product_event.dart';
import 'package:second_hand_app/bloc/my_product/my_product_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/market_repository.dart';

class MyProductBloc extends Bloc<MyProductPageEvent, MyProductState> {
  final MarketRepository _repository;

  MyProductBloc(this._repository) : super(MyProductInitState()) {
    on<GetMyProduct>(_getMyProducts);
    on<GetOfferedProduct>(_getOfferedProducts);
  }

  Future<void> _getMyProducts(
      GetMyProduct event, Emitter<MyProductState> emit) async {
    emit(MyProductLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final data = await _repository.getMyProducts(accessToken: accessToken!);
      emit(MyProductLoadedState(data));
    } catch (e) {
      emit(MyProductErrorState(e.toString()));
    }
  }

  Future<void> _getOfferedProducts(
      GetOfferedProduct event, Emitter<MyProductState> emit) async {
    emit(MyProductLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final data = await _repository.getOfferedProduct(
          accessToken: accessToken!, status: event.status);
      emit(MyProductLoadedState(data));
    } catch (e) {
      emit(MyProductErrorState(e.toString()));
    }
  }
}
