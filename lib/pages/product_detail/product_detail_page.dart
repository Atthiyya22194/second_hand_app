import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/poppins_text.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_text_field.dart';

import '../../bloc/product_detail/product_detail_page_bloc.dart';
import '../../bloc/product_detail/product_detail_page_events.dart';
import '../../bloc/product_detail/product_detail_page_states.dart';
import '../../models/product_detail_response.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/image_loader.dart';
import '../../widgets/rounded_border_container.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';

class ProductDetailpage extends StatelessWidget {
  const ProductDetailpage({Key? key, required this.id})
      : super(
          key: key,
        );

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailBloc(MarketRepository())..add(GetData(id)),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: BlocConsumer<ProductDetailBloc, ProductDetailPageState>(
          builder: (context, state) {
            if (state is ProductDetailPageLoadingState) {
              return const ShowLoading();
            }

            if (state is ProductDetailPageLoadedState) {
              final ProductDetailResponse product = state.products;
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
            if (state is ProductDetailPageErrorState) {
              BlocProvider.of<ProductDetailBloc>(context).add(GetData(id));
              showSnackBar(context, 'Something went wrong', state.error,
                  ContentType.failure);
            }
            if (state is BidSuccessState) {
              BlocProvider.of<ProductDetailBloc>(context).add(GetData(id));
              showSnackBar(context, 'Bid Successful', state.response,
                  ContentType.success);
            }
          },
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  const Content({super.key, required this.product});

  final ProductDetailResponse product;

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
          SellerInfo(product: widget.product),
          ProductDescription(product: widget.product),
          BidForm(product: widget.product)
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
            PoppinsText(text: 'Rp. ${product.basePrice}'),
          ],
        ),
      ),
    );
  }
}

class SellerInfo extends StatelessWidget {
  const SellerInfo({super.key, required this.product});

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
            margin: EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 8 * ffem, 0 * ffem),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding:
                    EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 0 * ffem, 4 * ffem),
                child: PoppinsText(
                  text: product.user?.fullName ?? "No user information",
                  fontWeight: FontWeight.w500,
                ),
              ),
              PoppinsText(
                text: product.user?.city ?? "No user information",
                fontSize: 13,
                color: const Color(0xff8a8a8a),
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

class BidForm extends StatefulWidget {
  const BidForm({super.key, required this.product});

  final ProductDetailResponse product;

  @override
  State<BidForm> createState() => _BidFormState();
}

class _BidFormState extends State<BidForm> {
  final TextEditingController bidController = TextEditingController();

  @override
  void dispose() {
    bidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      margin: EdgeInsets.fromLTRB(16 * ffem, 8 * ffem, 16 * ffem, 16 * ffem),
      child: Column(
        children: [
          RoundedTextField(
            hint: 'Rp. 10.000',
            title: 'Bid Price',
            controller: bidController,
          ),
          SizedBox(
            width: double.infinity,
            child: RoundedButton(
              onPressed: () {
                if (bidController.text.trim().isNotEmpty) {
                  BlocProvider.of<ProductDetailBloc>(context).add(
                    Order(
                      widget.product.id.toString(),
                      bidController.text.trim(),
                    ),
                  );
                } else {
                  showSnackBar(context, 'Something went wrong...',
                      'Fill bid price', ContentType.warning);
                }
              },
              text: "Start Bargain",
            ),
          ),
        ],
      ),
    );
  }
}
