import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/my_order/my_order_bloc.dart';
import 'package:second_hand_app/bloc/my_order/my_order_event.dart';
import 'package:second_hand_app/bloc/my_order/my_order_state.dart';
import 'package:second_hand_app/models/order_response.dart';
import 'package:second_hand_app/pages/my_order_detail_page/my_order_detail_page.dart';
import 'package:second_hand_app/repositories/market_repository.dart';
import 'package:second_hand_app/widgets/center_text_info.dart';
import 'package:second_hand_app/widgets/order_card.dart';
import 'package:second_hand_app/widgets/show_loading.dart';
import 'package:second_hand_app/widgets/show_snack_bar.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('My Order')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (context) =>
                MyOrderBloc(MarketRepository())..add(GetMyOrder()),
            child: const MyOrderList(),
          ),
        ));
  }
}

class MyOrderList extends StatelessWidget {
  const MyOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyOrderBloc, MyOrderState>(
      builder: (context, state) {
        if (state is MyOrderLoadingState) {
          return const ShowLoading();
        }
        if (state is MyOrderLoadedState) {
          List<OrderResponse> data = state.response;
          if (data.isNotEmpty) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                final order = data[index];
                return OrderCard(order: order, route:  MyOrderDetailpage(id: order.id.toString().trim()),);
              },
            );
          } else {
            return const CenterTextInfo(message: 'You hasn\'t order anything');
          }
        }
        return Container();
      },
      listener: (context, state) {
        if (state is MyOrderErrorState) {
          showSnackBar(context, 'Something went wrong...', state.error,
              ContentType.failure);
        }
      },
    );
  }
}
