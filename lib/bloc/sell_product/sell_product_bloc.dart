import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:second_hand_app/bloc/sell_product/sell_product_event.dart';
import 'package:second_hand_app/bloc/sell_product/sell_product_state.dart';
import 'package:second_hand_app/repositories/market_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellProductBloc extends Bloc<SellProductEvent, SellProductState> {
  final MarketRepository _repository;

  SellProductBloc(this._repository) : super(SellProductInitState()) {
    on<UploadProduct>(_uploadProduct);
    on<GetImage>(_getImage);
  }

  Future<void> _uploadProduct(
      UploadProduct event, Emitter<SellProductState> emit) async {
    emit(SellProductLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final response = await _repository.uploadProduct(
          accessToken: accessToken!,
          productname: event.productName,
          description: event.description,
          basePrice: event.basePrice,
          category: event.category,
          location: event.location,
          image: event.image);
      emit(SellProductSuccessState(response));
    } catch (e) {
      emit(SellProductErrorState(e.toString()));
    }
  }

  Future<void> _getImage(GetImage event, Emitter<SellProductState> emit) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,);
      final File imageFile = File(image!.path);
      emit(LoadImageState(imageFile));
    } catch (e) {
      emit(SellProductErrorState(e.toString()));
    }
  }
}
