import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/market_repository.dart';
import 'edit_product_event.dart';
import 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  EditProductBloc(this._repository) : super(EditProductInitState()) {
    on<EditProduct>(_editProduct);
    on<GetImage>(_getImage);
  }

  final MarketRepository _repository;

  Future<void> _editProduct(
      EditProduct event, Emitter<EditProductState> emit) async {
    emit(EditProductLoadingState());
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');
      final response = await _repository.editProduct(
          accessToken: accessToken!,
          productId: event.productId,
          productname: event.productName,
          description: event.description,
          basePrice: event.basePrice,
          category: event.category,
          location: event.location,
          image: event.image);
      emit(EditProductSuccessState(response));
    } catch (e) {
      emit(EditProductErrorState(e.toString()));
    }
  }

  Future<void> _getImage(GetImage event, Emitter<EditProductState> emit) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery,);
      final File imageFile = File(image!.path);
      emit(LoadImageState(imageFile));
    } catch (e) {
      emit(EditProductErrorState(e.toString()));
    }
  }
}
