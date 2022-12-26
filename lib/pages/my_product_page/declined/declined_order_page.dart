import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/my_product/my_product_bloc.dart';
import '../../../bloc/my_product/my_product_event.dart';
import '../../../bloc/my_product/my_product_state.dart';
import '../../../models/order_response.dart';
import '../../../repositories/market_repository.dart';
import '../../../widgets/center_text_info.dart';
import '../../../widgets/order_card.dart';
import '../../../widgets/show_loading.dart';
import '../../../widgets/show_snack_bar.dart';
import '../../offer_detail_page/offer_detail_page.dart';

class DeclinedOrderPage extends StatelessWidget {
  const DeclinedOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyProductBloc(MarketRepository())..add(GetOfferedProduct('declined')),
      child: Scaffold(
        body: BlocConsumer<MyProductBloc, MyProductState>(
          builder: (context, state) {
            if (state is MyProductLoadingState) {
              return const ShowLoading();
            }

            if (state is MyProductLoadedState) {
              List<OrderResponse> data = state.products;
              if (data.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (_, index) {
                    final order = data[index];
                    return OrderCard(
                      order: order,
                      route:  OfferDetailPage(orderId: order.id.toString().trim()),
                    );
                  },
                );
              } else {
                return const CenterTextInfo(
                  message: 'No Declined Order',
                );
              }
            }

            return Container();
          },
          listener: (context, state) {
            if (state is MyProductErrorState) {
              showSnackBar(context, 'Something went wrong', state.error,
                  ContentType.failure);
            }
          },
        ),
      ),
    );
  }
}
