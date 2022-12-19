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

class PendingOrderPage extends StatelessWidget {
  const PendingOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyProductBloc(MarketRepository())..add(GetOfferedProduct('pending')),
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
                  itemCount: data.length,
                  itemBuilder: (_, index) {
                    final order = data[index];
                    return OrderCard(
                      order: order,
                    );
                  },
                );
              } else {
                return const CenterTextInfo(
                    message: 'You don\'t have any Order');
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
