import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/offer_detail/offer_detail_bloc.dart';
import '../../bloc/offer_detail/offer_detail_event.dart';
import '../../bloc/offer_detail/offer_detail_state.dart';
import '../../models/order_response.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/action_button.dart';
import '../../widgets/image_loader.dart';
import '../../widgets/poppins_text.dart';
import '../../widgets/rounded_border_container.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';
import '../patch_result_page/patch_result_page.dart';

class OfferDetailPage extends StatelessWidget {
  const OfferDetailPage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PoppinsText(
          text: 'Offer Detail',
          fontWeight: FontWeight.w700,
          fontSize: 20,
          height: 1.5,
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            OfferDetailBloc(MarketRepository())..add(GetOfferDetail(orderId)),
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
            return Container();
          },
          listener: (context, state) {
            if (state is OfferDetailErrorState) {
              showSnackBar(context, 'Something went wrong', state.error,
                  ContentType.failure);
            }
            if (state is PatchSuccessState) {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) => PatchResultPage(orderId: orderId),
                ),
              );
            }
            if (state is WhatAppLaunchedState) {
              BlocProvider.of<OfferDetailBloc>(context)
                  .add(GetOfferDetail(orderId));
            }
          },
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key, required this.order});

  final OrderResponse order;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    final String message =
        'Hi! ${order.user?.fullName}, I\'s ${order.product.user?.fullName} seller from Second Hand App interest with your bid price from ${order.productName}, would you mind to continue this transaction?';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BuyerInfo(order: order),
        ProductInfo(order: order),
        Container(
          padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem * fem, 16 * fem, 0),
          width: double.infinity,
          child: ActionButton(
            orderId: order.id.toString(),
            status: order.status,
            phoneNumber: order.user?.phoneNumber,
            message: message,
          ),
        )
      ],
    );
  }
}

class BuyerInfo extends StatelessWidget {
  const BuyerInfo({super.key, required this.order});

  final OrderResponse order;

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
  const ProductInfo({super.key, required this.order});

  final OrderResponse order;

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
                text: 'Offered Product',
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
                  text: "TL. ${order.basePrice}",
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 4 * fem, 0, 0),
                child: PoppinsText(
                  text: "Offered TL. ${order.price}",
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
