import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/market_repository.dart';
import 'home_page_events.dart';
import 'home_page_states.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc(this._repository) : super(HomePageInitState()) {
    on<GetProducts>(_getProduct);
  }

  final MarketRepository _repository;

  Future<void> _getProduct(
      GetProducts event, Emitter<HomePageState> emit) async {
    emit(HomePageLoadingState());
    try {
      final data = await _repository.getProducts(event.productName,event.categoryId);
      emit(HomePageLoadedState(data));
    } catch (e) {
      emit(HomePageErrorState(e.toString()));
    }
  }
}
