import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/product_detail/product_detail_page_events.dart';
import 'package:second_hand_app/bloc/product_detail/product_detail_page_states.dart';

import '../../repositories/product_detail_page_repository.dart';

class ProductDetailBloc
    extends Bloc<ProductDetailPageEvent, ProductDetailPageState> {
  final ProductDetailPageRepository _repository;

  ProductDetailBloc(this._repository, String id)
      : super(ProductDetailPageLoadingState()) {
    on<ProductDetailPageEvent>((event, emit) async {
      emit(ProductDetailPageLoadingState());
      try {
        final data = await _repository.getDetail(id);
        emit(ProductDetailPageLoadedState(data));
      } catch (e) {
        emit(ProductDetailPageErrorState(e.toString()));
      }
    });
  }
}
