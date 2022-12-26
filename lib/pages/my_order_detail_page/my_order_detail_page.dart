import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../my_order_page/my_order_page.dart';
import '../../bloc/my_order_detail/my_order_detail_event.dart';
import '../../models/order_response.dart';

import '../../bloc/my_order_detail/my_order_detail_bloc.dart';
import '../../bloc/my_order_detail/my_order_detail_state.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/image_loader.dart';
import '../../widgets/poppins_text.dart';
import '../../widgets/rounded_border_container.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_text_field.dart';
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
          
          title: const PoppinsText(
            text: 'My Order Detail',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            height: 1.5,
          ),
        ),
        body: BlocConsumer<MyOrderDetailBloc, MyOrderDetailState>(
          builder: (context, state) {
            if (state is MyOrderDetailLoadingState) {
              return const ShowLoading();
            }

            if (state is MyOrderDetailLoadedState) {
              final OrderResponse product = state.response;
              return Content(
                order: product,
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: ((context) => const MyOrderPage()),
                ),
              );
              showSnackBar(context, 'Order Deleted', state.response,
                  ContentType.success);
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
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageLoader(
            imageUrl: order.imageProduct,
            height: size.height * 0.4,
            width: size.width,
          ),
          ProductInfo(order: order),
          SellerInfo(order: order),
          ProductDescription(order: order),
          BidForm(order: order)
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
    double ffem = fem * 0.97;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: RoundedBorderContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 0 * ffem, 4 * ffem),
              child: PoppinsText(
                text: order.productName,
                fontWeight: FontWeight.w500,
              ),
            ),
            PoppinsText(text: 'Rp. ${order.basePrice}'),
          ],
        ),
      ),
    );
  }
}

class SellerInfo extends StatelessWidget {
  final OrderResponse order;
  const SellerInfo({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return RoundedBorderContainer(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 8 * ffem, 0 * ffem),
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
              Container(
                padding:
                    EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 0 * ffem, 4 * ffem),
                child: PoppinsText(
                  text: order.user?.fullName ?? "No user information",
                  fontWeight: FontWeight.w500,
                ),
              ),
              PoppinsText(
                text: order.user?.city ?? "No user information",
                fontSize: 13,
                color: const Color(0xff8a8a8a),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductDescription extends StatelessWidget {
  final OrderResponse order;
  const ProductDescription({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return RoundedBorderContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 0 * ffem, 4 * ffem),
            child: const PoppinsText(
              text: 'Description',
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            padding:
                EdgeInsets.fromLTRB(0 * ffem, 0 * ffem, 0 * ffem, 4 * ffem),
            child: PoppinsText(
              text: order.product.description,
              fontSize: 13,
              color: const Color(0xff8a8a8a),
            ),
          ),
        ],
      ),
    );
  }
}

class BidForm extends StatefulWidget {
  final OrderResponse order;
  const BidForm({super.key, required this.order});

  @override
  State<BidForm> createState() => _BidFormState();
}

class _BidFormState extends State<BidForm> {
  final TextEditingController bidController = TextEditingController();
  @override
  void dispose() {
    bidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      margin: EdgeInsets.fromLTRB(16 * ffem, 8 * ffem, 16 * ffem, 16 * ffem),
      child: Column(
        children: [
          RoundedTextField(
            hint: 'Rp. 10.000',
            title: 'Bid Price',
            controller: bidController,
          ),
          SizedBox(
            width: double.infinity,
            child: RoundedButton(
              onPressed: () {
                if (bidController.text.trim().isNotEmpty) {
                  BlocProvider.of<MyOrderDetailBloc>(context).add(
                    PutMyBidPrice(
                      id: widget.order.productId.toString(),
                      bidPrice: bidController.text.trim(),
                    ),
                  );
                } else {
                  showSnackBar(context, 'Something went wrong...',
                      'Fill bid price', ContentType.warning);
                }
              },
              text: "Change bid price",
            ),
          ),
          Container(
            padding:
                EdgeInsets.fromLTRB(0 * ffem, 8 * ffem, 0 * ffem, 0 * ffem),
            width: double.infinity,
            child: RoundedButton(
              onPressed: () {
                BlocProvider.of<MyOrderDetailBloc>(context).add(
                  DeleteMyOrder(id: widget.order.id.toString()),
                );
              },
              text: "Delete order",
            ),
          ),
        ],
      ),
    );
  }
}
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: ImageLoader(
//                 imageUrl: widget.product.imageProduct,
//                 height: size.height * 0.4,
//                 width: size.width,
//               )),
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(widget.product.productName),
//                 const Padding(
//                   padding: EdgeInsets.only(top: 8.0),
//                   child: Text('Base price'),
//                 ),
//                 Text(widget.product.basePrice.toString()),
//                 const Padding(
//                   padding: EdgeInsets.only(top: 8.0),
//                   child: Text('Your bid price'),
//                 ),
//                 Text(widget.product.price.toString())
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.only(bottom: 8.0),
//                   child: Text('Seller Info'),
//                 ),
//                 Text(widget.product.product.user?.fullName ??
//                     "No user information"),
//                 Text(widget.product.product.user?.city ?? "No user information")
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text('Description'),
//                 Text(widget.product.product.description)
//               ],
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
//             child: Column(
//               children: [
//                 TextField(
//                   keyboardType: TextInputType.number,
//                   controller: bidController,
//                   decoration: const InputDecoration(labelText: 'Bid Price'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     if (bidController.text.trim().isNotEmpty) {
//                       BlocProvider.of<MyOrderDetailBloc>(context).add(
//                           PutMyBidPrice(
//                               id: widget.product.id.toString(),
//                               bidPrice: bidController.text.trim()));
//                     } else {
//                       showSnackBar(context, 'Something went wrong...',
//                           'Fill bid price', ContentType.warning);
//                     }
//                   },
//                   child: const Text("Change Bid Price"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     BlocProvider.of<MyOrderDetailBloc>(context).add(
//                       DeleteMyOrder(id: widget.product.id.toString()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                       primary: CupertinoColors.destructiveRed),
//                   child: const Text("Delete Order"),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
