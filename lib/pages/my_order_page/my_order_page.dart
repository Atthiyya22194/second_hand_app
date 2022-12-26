import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/poppins_text.dart';
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavBar(),
              ),
            );
          },
        ),
        title: const PoppinsText(
          text: 'My Order',
          fontWeight: FontWeight.w700,
          fontSize: 20,
          height: 1.5,
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(24 * fem, 16 * fem, 24 * fem, 8 * fem),
        child: BlocProvider(
          create: (context) =>
              MyOrderBloc(MarketRepository())..add(GetMyOrder()),
          child: const MyOrderList(),
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
              shrinkWrap: true,
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
