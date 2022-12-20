import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/my_detail_order/my_order_detail_event.dart';
import 'package:second_hand_app/models/order_response.dart';

import '../../bloc/my_detail_order/my_order_detail_bloc.dart';
import '../../bloc/my_detail_order/my_order_detail_state.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/image_loader.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';

class MyOrderDetailpage extends StatelessWidget {
  final String id;
  const MyOrderDetailpage({Key? key, required this.id})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyOrderDetailBloc(MarketRepository())..add(GetMyOrderDetail(id: id)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Order Detail'),
        ),
        body: BlocConsumer<MyOrderDetailBloc, MyOrderDetailState>(
          builder: (context, state) {
            if (state is MyOrderDetailLoadingState) {
              return const ShowLoading();
            }

            if (state is MyOrderDetailLoadedState) {
              final OrderResponse product = state.response;
              return Content(
                product: product,
              );
            }
            return Container();
          },
          listener: (context, state) {
            if (state is MyOrderDetailErrorState) {
              showSnackBar(context, 'Something went wrong', state.error,
                  ContentType.failure);
            }
            if (state is PatchBidSuccessState) {
              showSnackBar(context, 'Bid Successful', state.response,
                  ContentType.success);
              BlocProvider.of<MyOrderDetailBloc>(context)
                  .add(GetMyOrderDetail(id: id));
            }
            if (state is DeleteOrderSuccessState) {
              Navigator.pop(context);
              showSnackBar(context, 'Order Deleted', state.response,
                  ContentType.success);
            }
          },
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  final OrderResponse product;
  const Content({super.key, required this.product});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final TextEditingController bidController = TextEditingController();

  @override
  void dispose() {
    bidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ImageLoader(
                imageUrl: widget.product.imageProduct,
                height: size.height * 0.4,
                width: size.width,
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.product.productName),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('Base price'),
                ),
                Text(widget.product.basePrice.toString()),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('Your bid price'),
                ),
                Text(widget.product.price.toString())
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text('Seller Info'),
                ),
                Text(widget.product.product.user?.fullName ??
                    "No user information"),
                Text(widget.product.product.user?.city ?? "No user information")
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Description'),
                Text(widget.product.product.description)
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  controller: bidController,
                  decoration: const InputDecoration(labelText: 'Bid Price'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (bidController.text.trim().isNotEmpty) {
                      BlocProvider.of<MyOrderDetailBloc>(context).add(
                          PutMyBidPrice(
                              id: widget.product.id.toString(),
                              bidPrice: bidController.text.trim()));
                    } else {
                      showSnackBar(context, 'Something went wrong...',
                          'Fill bid price', ContentType.warning);
                    }
                  },
                  child: const Text("Change Bid Price"),
                ),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<MyOrderDetailBloc>(context).add(
                      DeleteMyOrder(id: widget.product.id.toString()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      primary: CupertinoColors.destructiveRed),
                  child: const Text("Delete Order"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
