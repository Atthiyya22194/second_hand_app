import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home_page/home_page.dart';
import '../../widgets/rounded_button.dart';

import '../../bloc/offer_detail/offer_detail_bloc.dart';
import '../../bloc/offer_detail/offer_detail_event.dart';
import '../../bloc/offer_detail/offer_detail_state.dart';
import '../../models/order_response.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/image_loader.dart';
import '../../widgets/poppins_text.dart';
import '../../widgets/rounded_border_container.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';

class PatchResultPage extends StatelessWidget {
  final String orderId;
  const PatchResultPage({Key? key, required this.orderId})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocProvider(
            create: (context) => OfferDetailBloc(MarketRepository())
              ..add(GetOfferDetail(orderId)),
            child: BlocConsumer<OfferDetailBloc, OfferDetailState>(
              builder: (context, state) {
                if (state is OfferDetailLoadingState) {
                  return const ShowLoading();
                }

                if (state is OfferDetailLoadedState) {
                  final OrderResponse order = state.order;
                  return Content(
                    order: order,
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
                if (state is OfferDetailErrorState) {
                  showSnackBar(context, 'Something went wrong', state.error,
                      ContentType.failure);
                }
                if (state is WhatAppLaunchedState) {
                  BlocProvider.of<OfferDetailBloc>(context).add(
                    GetOfferDetail(orderId),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final OrderResponse order;
  const Content({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final String message =
        'Halo ${order.user?.fullName}, saya ${order.product.user?.fullName} penjual dari Second Hand App tertarik dengan harga yang ditawarkan atas barang ${order.productName}';
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PatchIcon(order: order),
        BuyerInfo(order: order),
        ProductInfo(order: order),
        Container(
          padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem * fem, 16 * fem, 0),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(8 * fem, 0, 0, 0),
                  child: RoundedButton(
                      text: 'Contact Buyer',
                      onPressed: () {
                        if (order.user!.phoneNumber!.isNotEmpty) {
                          BlocProvider.of<OfferDetailBloc>(context).add(
                            OpenWhatsApp(
                                "62${order.user?.phoneNumber}", message),
                          );
                        } else {
                          showSnackBar(
                              context,
                              "Something went wrong...",
                              "buyer doesn't have phone number",
                              ContentType.warning);
                        }
                      }),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(8 * fem, 0, 0, 0),
                  child: RoundedButton(
                    text: 'Back to Home Page',
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class PatchIcon extends StatelessWidget {
  final OrderResponse order;
  const PatchIcon({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem, 16 * fem, 16 * fem),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (order.status == 'accepted') ...[
            Icon(
              CupertinoIcons.checkmark_seal_fill,
              color: Colors.green,
              size: size.width * 0.35,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: PoppinsText(
                text: 'Offer Accepted',
                fontWeight: FontWeight.w800,
              ),
            ),
          ] else if (order.status == 'declined') ...[
            Icon(
              CupertinoIcons.xmark_circle_fill,
              color: Colors.red,
              size: size.width * 0.3,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: PoppinsText(
                text: 'Offer Declined',
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class BuyerInfo extends StatelessWidget {
  final OrderResponse order;
  const BuyerInfo({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return RoundedBorderContainer(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 8 * fem, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12 * fem),
              child: ImageLoader(
                height: 70 * fem,
                width: 70 * fem,
                imageUrl: order.user?.imageUrl,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              PoppinsText(
                text: order.user?.fullName ?? "No user information",
                fontWeight: FontWeight.w500,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 4 * fem, 0, 0),
                child: PoppinsText(
                  text: order.user?.city ?? "No user information",
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

class ProductInfo extends StatelessWidget {
  final OrderResponse order;
  const ProductInfo({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      padding: EdgeInsets.fromLTRB(16 * fem, 0, 16 * fem, 0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 8 * fem, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12 * fem),
              child: ImageLoader(
                height: 70 * fem,
                width: 70 * fem,
                imageUrl: order.imageProduct,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const PoppinsText(
                text: 'Penawaran produk',
                fontSize: 13,
                color: Color(0xff8a8a8a),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 4 * fem, 0, 0),
                child: PoppinsText(
                  text: order.productName,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 4 * fem, 0, 0),
                child: PoppinsText(
                  text: "Rp. ${order.basePrice}",
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 4 * fem, 0, 0),
                child: PoppinsText(
                  text: "Ditawar. ${order.price}",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
