import 'package:flutter/material.dart';
import 'package:second_hand_app/models/order_response.dart';
import 'package:second_hand_app/pages/offer_detail_page/offer_detail_page.dart';


class OrderCard extends StatelessWidget {
  final OrderResponse order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Image.network(
          order.imageProduct,
          width: 100,
        ),
        title: Text(
          order.productName,
        ),
        subtitle: Text(order.basePrice.toString()),
        onTap: () => {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) =>
                  OfferDetailPage(orderId: order.id.toString().trim()),
            ),
          )
        },
      ),
    );
  }
}
