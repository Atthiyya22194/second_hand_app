import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/my_product-detail/my_product_detail_bloc.dart';
import '../../bloc/my_product-detail/my_product_detail_event.dart';
import '../../widgets/poppins_text.dart';
import '../../widgets/rounded_border_container.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_text_field.dart';
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

class Content extends StatefulWidget {
  final ProductDetailResponse product;
  const Content({super.key, required this.product});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageLoader(
            imageUrl: widget.product.imageUrl,
            height: size.height * 0.4,
            width: size.width,
          ),
          ProductInfo(product: widget.product),
          SellertInfo(product: widget.product),
          ProductDescription(product: widget.product),
          const EditProductButton()
        ],
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  final ProductDetailResponse product;
  const ProductInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: RoundedBorderContainer(
        product: product,
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
            Container(
              padding:
                  EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 0 * ffem, 4 * ffem),
              child: PoppinsText(
                text: product.categories[0].name,
                fontSize: 13,
                color: const Color(0xff8a8a8a),
              ),
            ),
            PoppinsText(text: 'Rp. ${product.basePrice}'),
          ],
        ),
      ),
    );
  }
}

class SellertInfo extends StatelessWidget {
  final ProductDetailResponse product;
  const SellertInfo({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return RoundedBorderContainer(
      product: product,
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
  final ProductDetailResponse product;
  const ProductDescription({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return RoundedBorderContainer(
      product: product,
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
  const EditProductButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      margin: EdgeInsets.fromLTRB(24 * fem, 0 * fem, 24 * fem, 0 * fem),
      width: double.infinity,
      child: RoundedButton(onPressed: () {}, text: 'Edit Product'),
    );
  }
}
