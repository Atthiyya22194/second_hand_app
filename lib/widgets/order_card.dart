import 'package:flutter/material.dart';
import '../models/order_response.dart';

class OrderCard extends StatelessWidget {
  final OrderResponse order;
  final Widget route;

  const OrderCard({Key? key, required this.order, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: 'order image',
          child: Image.network(
            order.imageProduct,
            width: 100,
          ),
        ),
        title: Text(
          order.productName,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Price ${order.basePrice}"),
            Text("Bid Price ${order.price}"),
          ],
        ),
        onTap: () => {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              builder: (context) => route,
            ),
          )
        },
      ),
    );
  }
}
