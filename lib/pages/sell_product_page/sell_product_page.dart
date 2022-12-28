import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/sell_product/sell_product_bloc.dart';
import '../../bloc/sell_product/sell_product_event.dart';
import '../../bloc/sell_product/sell_product_state.dart';
import '../../common/common.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/dropdown_category.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_text_field.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';

class SellProductPage extends StatelessWidget {
  const SellProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SellProductBloc>(
      create: (context) => SellProductBloc(MarketRepository()),
      child: const Scaffold(body: SellProductForm()),
    );
  }
}

class SellProductForm extends StatefulWidget {
  const SellProductForm({super.key});

  @override
  State<SellProductForm> createState() => _SellProductForm();
}

class _SellProductForm extends State<SellProductForm> {
  String? categoryId = "1";
  final TextEditingController descController = TextEditingController();

  final TextEditingController locationController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  String? selectedCategory;

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    priceController.dispose();
    locationController.dispose();
    super.dispose();
  }

  _formValidation<bool>() {
    if (nameController.text.isEmpty &&
        descController.text.isEmpty &&
        priceController.text.isEmpty &&
        locationController.text.isEmpty) {
      showSnackBar(context, 'Something went wrong...', 'Please fill all form',
          ContentType.warning);
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedTextField(
              hint: 'Product name',
              title: 'Product name',
              controller: nameController,
            ),
            RoundedTextField(
              hint: 'TL. 10.000',
              title: 'Product price',
              controller: priceController,
            ),
            DropdownCategory(
              value: selectedCategory,
              items: categoryItems().map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              onchanged: (String? newValue) {
                setState(() {
                  categoryItems();
                  int id = categoryItems().indexOf(newValue!) + 1;
                  categoryId = id.toString();
                  selectedCategory = newValue;
                });
              },
            ),
            RoundedTextField(
              hint: 'Konya',
              title: 'Your location',
              controller: locationController,
            ),
            RoundedTextField(
              hint: 'Description',
              title: 'Product description',
              controller: descController,
            ),
            BlocConsumer<SellProductBloc, SellProductState>(
              builder: (context, state) {
                if (state is LoadImageState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => BlocProvider.of<SellProductBloc>(context)
                            .add(GetImage()),
                        child: SizedBox(
                            width: 120 * fem,
                            height: 120 * fem,
                            child: Image.file(state.image)),
                      ),
                      RoundedButton(
                        onPressed: () {
                          if (_formValidation() == true) {
                            BlocProvider.of<SellProductBloc>(context).add(
                              UploadProduct(
                                  productName: nameController.text,
                                  description: descController.text,
                                  basePrice: priceController.text,
                                  category: categoryId!,
                                  location: locationController.text,
                                  image: state.image),
                            );
                          }
                        },
                        text: 'Upload',
                      ),
                    ],
                  );
                }
                if (state is SellProductLoadingState) {
                  return const ShowLoading();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => BlocProvider.of<SellProductBloc>(context)
                          .add(GetImage()),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all()),
                        width: 120 * fem,
                        height: 120 * fem,
                        child: const Center(
                          child: Icon(CupertinoIcons.add),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: RoundedButton(
                        text: 'Upload',
                        onPressed: () {
                          _formValidation();
                        },
                      ),
                    )
                  ],
                );
              },
              listener: (context, state) {
                if (state is SellProductSuccessState) {
                  showSnackBar(
                      context, 'Success!', state.response, ContentType.success);
                }
                if (state is SellProductErrorState) {
                  showSnackBar(
                      context, 'Failed', state.error, ContentType.failure);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
