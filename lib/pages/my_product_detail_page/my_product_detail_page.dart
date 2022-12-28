import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../edit_product_page/edit_product_page.dart';
import '../../bloc/my_product-detail/my_product_detail_bloc.dart';
import '../../bloc/my_product-detail/my_product_detail_event.dart';
import '../../widgets/poppins_text.dart';
import '../../widgets/rounded_border_container.dart';
import '../../widgets/rounded_button.dart';

import '../../bloc/my_product-detail/my_product_detail_state.dart';
import '../../models/product_detail_response.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/image_loader.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';

class MyProductDetailPage extends StatelessWidget {
  const MyProductDetailPage({Key? key, required this.id})
      : super(
          key: key,
        );

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyProductDetailBloc(MarketRepository())
        ..add(GetMyProductDetail(id: id)),
      child: Scaffold(
        appBar: AppBar(
          title: const PoppinsText(
            text: 'My Product',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            height: 1.5,
          ),
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
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Something went wrong...'),
                  ],
                ),
              ],
            );
          },
          listener: (context, state) {
            if (state is MyProductDetailErrorState) {
              BlocProvider.of<MyProductDetailBloc>(context)
                  .add(GetMyProductDetail(id: id));
              showSnackBar(context, 'Something went wrong', state.error,
                  ContentType.failure);
            }
          },
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key, required this.product});

  final ProductDetailResponse product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageLoader(
            imageUrl: product.imageUrl,
            height: size.height * 0.4,
            width: size.width,
          ),
          ProductInfo(product: product),
          SellertInfo(product: product),
          ProductDescription(product: product),
          EditProductButton(productId: product.id.toString())
        ],
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key, required this.product});

  final ProductDetailResponse product;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: RoundedBorderContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 0 * ffem, 4 * ffem),
              child: PoppinsText(
                text: product.name,
                fontWeight: FontWeight.w500,
              ),
            ),
            PoppinsText(text: 'TL. ${product.basePrice}'),
          ],
        ),
      ),
    );
  }
}

class SellertInfo extends StatelessWidget {
  const SellertInfo({super.key, required this.product});

  final ProductDetailResponse product;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return RoundedBorderContainer(
      child: Row(
        children: [
          Container(
            padding:
                EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 8 * ffem, 0 * ffem),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12 * fem),
              child: ImageLoader(
                height: 70 * fem,
                width: 70 * fem,
                imageUrl: product.user?.imageUrl,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 0 * ffem, 4 * ffem),
                child: PoppinsText(
                  text: product.user?.fullName ?? "No user information",
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding:
                    EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 0 * ffem, 4 * ffem),
                child: PoppinsText(
                  text: product.user?.city ?? "No user information",
                  fontSize: 13,
                  color: const Color(0xff8a8a8a),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key, required this.product});

  final ProductDetailResponse product;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return RoundedBorderContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 0 * ffem, 4 * ffem),
            child: const PoppinsText(
              text: 'Description',
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding:
                EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 0 * ffem, 4 * ffem),
            child: PoppinsText(
              text: product.description,
              fontSize: 13,
              color: const Color(0xff8a8a8a),
            ),
          ),
        ],
      ),
    );
  }
}

class EditProductButton extends StatelessWidget {
  final String productId;
  const EditProductButton({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      margin: EdgeInsets.fromLTRB(24 * fem, 0 * fem, 24 * fem, 0 * fem),
      width: double.infinity,
      child: RoundedButton(
          onPressed: () {
            print(productId);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProductPage(productId: productId),
              ),
            );
          },
          text: 'Edit Product'),
    );
  }
}
