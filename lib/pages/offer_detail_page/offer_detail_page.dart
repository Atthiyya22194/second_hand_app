import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/offer_detail/offer_detail_bloc.dart';
import '../../bloc/offer_detail/offer_detail_event.dart';
import '../../bloc/offer_detail/offer_detail_state.dart';
import '../../models/order_response.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bidder_info.dart';
import '../../widgets/product_info.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';
import '../patch_result_page/patch_result_page.dart';

class OfferDetailPage extends StatelessWidget {
  final String orderId;
  const OfferDetailPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offer Info'),
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
  final OrderResponse order;
  const Content({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final String message =
        'Halo ${order.user?.fullName}, saya ${order.product.user?.fullName} penjual dari Second Hand App tertarik dengan harga yang ditawarkan atas barang ${order.productName}';
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: BidderInfo(order: order),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ProductInfo(order: order),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ActionButton(
              orderId: order.id.toString(),
              status: order.status,
              phoneNumber: order.user?.phoneNumber,
              message: message,
            ),
          )
        ],
      ),
    );
  }
}
