import 'package:flutter/material.dart';

import '../models/order_response.dart';
import 'image_loader.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo({super.key, required this.order});

  final OrderResponse order;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text('Offered Product'),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ImageLoader(
                imageUrl: order.imageProduct,
                height: size.height * 0.20,
                width: size.width * 0.4),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.productName),
                  Text('Your price ${order.basePrice.toString()}'),
                  Text('Offered price ${order.price.toString()}')
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
