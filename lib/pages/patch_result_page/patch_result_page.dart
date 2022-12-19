import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/order_response.dart';
import '../../widgets/bidder_info.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/product_info.dart';

import '../../bloc/offer_detail/offer_detail_bloc.dart';
import '../../bloc/offer_detail/offer_detail_event.dart';
import '../../bloc/offer_detail/offer_detail_state.dart';
import '../../repositories/market_repository.dart';
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
        child: BlocProvider(
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
            },
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
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (order.status == 'accepted') ...[
                Icon(
                  CupertinoIcons.checkmark_seal_fill,
                  color: Colors.green,
                  size: size.width * 0.35,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Offer Accepted',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
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
                  child: Text(
                    'Offer Declined',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BidderInfo(order: order),
              ),
              ProductInfo(order: order),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBar(),
                    ),
                  );
                },
                child: const Text('Back to home page'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
