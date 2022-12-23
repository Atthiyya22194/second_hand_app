import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/widgets/poppins_text.dart';
import '../../bloc/my_order/my_order_bloc.dart';
import '../../bloc/my_order/my_order_event.dart';
import '../../bloc/my_order/my_order_state.dart';
import '../../models/order_response.dart';
import '../my_order_detail_page/my_order_detail_page.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/center_text_info.dart';
import '../../widgets/order_card.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(24 * fem, 16 * fem, 24 * fem, 8 * fem),
          child: BlocProvider(
            create: (context) =>
                MyOrderBloc(MarketRepository())..add(GetMyOrder()),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                PoppinsText(
                  text: 'My Ordered Product',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
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
                return OrderCard(
                  order: order,
                  route: MyOrderDetailpage(id: order.id.toString().trim()),
                );
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
