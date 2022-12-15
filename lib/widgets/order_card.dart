import 'package:flutter/material.dart';
import 'package:second_hand_app/models/order_response.dart';

import '../pages/product_detail/product_detail_page.dart';

class OrderCard extends StatelessWidget {
  final OrderResponse order;
  final bool isPending;

  const OrderCard({Key? key, required this.order, required this.isPending})
      : super(key: key);

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
          if (isPending == true)
            {
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailpage(id: order.productId.toString()),
                ),
              ),
            }
          else
            {null}
        },
      ),
    );
  }
}
