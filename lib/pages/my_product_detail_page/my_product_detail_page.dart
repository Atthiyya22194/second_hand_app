import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/my_product-detail/my_product_detail_bloc.dart';
import '../../bloc/my_product-detail/my_product_detail_event.dart';
import '../my_product_page/my_product_page.dart';

import '../../bloc/my_product-detail/my_product_detail_state.dart';
import '../../models/product_detail_response.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/image_loader.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';

class MyProductDetailPage extends StatelessWidget {
  final String id;
  const MyProductDetailPage({Key? key, required this.id})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyProductDetailBloc(MarketRepository())
        ..add(GetMyProductDetail(id: id)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Detail'),
        ),
        body: BlocConsumer<MyProductDetailBloc, MyProductDetailState>(
          builder: (context, state) {
            if (state is MyProductDetailLoadingState) {
              return const ShowLoading();
            }

            if (state is MyProductDetailLoadedState) {
              final ProductDetailResponse product = state.response;
              return Content(
                product: product,
              );
            }
            return Container();
          },
          listener: (context, state) {
            if (state is MyProductDetailErrorState) {
              showSnackBar(context, 'Something went wrong', state.error,
                  ContentType.failure);
            }
            if (state is DeleteProductSuccessState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyProductPage()));
              showSnackBar(context, 'Product Deleted', state.response,
                  ContentType.success);
            }
          },
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  final ProductDetailResponse product;
  const Content({super.key, required this.product});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final TextEditingController bidController = TextEditingController();

  @override
  void dispose() {
    bidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ImageLoader(
                imageUrl: widget.product.imageUrl,
                height: size.height * 0.4,
                width: size.width,
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.product.name),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('Base price'),
                ),
                Text(widget.product.basePrice.toString()),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('Your bid price'),
                ),
                Text(widget.product.basePrice.toString())
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text('Seller Info'),
                ),
                Text(widget.product.user?.fullName ?? "No user information"),
                Text(widget.product.user?.city ?? "No user information")
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Description'),
                Text(widget.product.description)
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<MyProductDetailBloc>(context).add(
                      DeleteMyProduct(id: widget.product.id.toString()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      primary: CupertinoColors.destructiveRed),
                  child: const Text("Delete Product"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
