import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/sell_product/sell_product_bloc.dart';
import 'package:second_hand_app/bloc/sell_product/sell_product_event.dart';
import 'package:second_hand_app/bloc/sell_product/sell_product_state.dart';
import 'package:second_hand_app/common/common.dart';
import 'package:second_hand_app/repositories/market_repository.dart';
import 'package:second_hand_app/widgets/show_loading.dart';
import 'package:second_hand_app/widgets/show_snack_bar.dart';

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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  String? categoryId;
  String? selectedCategory;
  var list = [
    'Elektronik',
    'Komputer dan Aksesoris',
    'Handphone dan Aksesoris',
    'Pakaian Pria',
    'Sepatu Pria',
    'Tas Pria',
    'Aksesoris Fashion',
    'Kesehatan',
    'Hobi dan Koleksi',
    'Makanan dan Minuman',
    'Perawatan dan Kecantikan',
    'Perlengkapan Rumah',
    'Pakaian Wanita',
    'Fashion Muslim',
    'Fashion bayi dan Anak',
    'Ibu dan Bayi',
    'Sepatu Wanita',
    'Tas Wanita',
    'Otomotif',
    'Olahraga dan Outdoor',
    'Buku dan Alat Tulis',
    'Voucher',
    'Souvenir dan Pesta',
    'Fotografi'
  ];

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Upload a product'),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Product Name'),
          ),
          TextField(
            controller: descController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Price'),
          ),
          DropdownButton(
              value: selectedCategory,
              hint: const Text('Select Category'),
              items: list.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  categoryItems();
                  int id = list.indexOf(newValue!) + 1;
                  categoryId = id.toString();
                  selectedCategory = newValue;
                });
              }),
          TextField(
            controller: locationController,
            decoration: const InputDecoration(labelText: 'location'),
          ),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<SellProductBloc>(context).add(GetImage());
              },
              child: const Text('Choose Image')),
          BlocConsumer<SellProductBloc, SellProductState>(
            builder: (context, state) {
              if (state is LoadImageState) {
                return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<SellProductBloc>(context).add(
                          UploadProduct(
                              productName: nameController.text,
                              description: descController.text,
                              basePrice: priceController.text,
                              category: categoryId!,
                              location: locationController.text,
                              image: state.image));
                    },
                    child: const Text('Upload'));
              }
              if (state is SellProductLoadingState) {
                return const ShowLoading();
              }
              return Container();
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
    );
  }
}
