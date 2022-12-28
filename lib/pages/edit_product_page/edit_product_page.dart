import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/edit_product/edit_product_bloc.dart';
import '../../bloc/edit_product/edit_product_event.dart';
import '../../bloc/edit_product/edit_product_state.dart';
import '../../common/common.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/dropdown_category.dart';
import '../../widgets/poppins_text.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_text_field.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';

class EditProductPage extends StatelessWidget {
  final String productId;
  const EditProductPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProductBloc>(
      create: (context) => EditProductBloc(MarketRepository()),
      child: Scaffold(
          appBar: AppBar(
            title: const PoppinsText(
              text: 'My Product',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              height: 1.5,
            ),
          ),
          body: EditProductForm(
            productId: productId,
          )),
    );
  }
}

class EditProductForm extends StatefulWidget {
  final String productId;
  const EditProductForm({super.key, required this.productId});

  @override
  State<EditProductForm> createState() => _EditProductForm();
}

class _EditProductForm extends State<EditProductForm> {
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
              hint: 'TL. 10',
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
            BlocConsumer<EditProductBloc, EditProductState>(
              builder: (context, state) {
                if (state is LoadImageState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => BlocProvider.of<EditProductBloc>(context)
                            .add(GetImage()),
                        child: SizedBox(
                            width: 120 * fem,
                            height: 120 * fem,
                            child: Image.file(state.image)),
                      ),
                      RoundedButton(
                        onPressed: () {
                          BlocProvider.of<EditProductBloc>(context).add(
                            EditProduct(
                              productId: widget.productId,
                              productName: nameController.text,
                              description: descController.text,
                              basePrice: priceController.text,
                              category: categoryId!,
                              location: locationController.text,
                              image: state.image,
                            ),
                          );
                        },
                        text: 'Upload',
                      ),
                    ],
                  );
                }
                if (state is EditProductLoadingState) {
                  return const ShowLoading();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => BlocProvider.of<EditProductBloc>(context)
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
                        text: 'Edit Product',
                        onPressed: () {
                          BlocProvider.of<EditProductBloc>(context).add(
                            EditProduct(
                              productId: widget.productId,
                              productName: nameController.text,
                              description: descController.text,
                              basePrice: priceController.text,
                              category: categoryId!,
                              location: locationController.text,
                              image: null,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              },
              listener: (context, state) {
                if (state is EditProductSuccessState) {
                  showSnackBar(
                      context, 'Success!', state.response, ContentType.success);
                }
                if (state is EditProductErrorState) {
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
