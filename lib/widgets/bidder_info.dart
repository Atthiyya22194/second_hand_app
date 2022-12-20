import 'package:flutter/cupertino.dart';

import '../models/order_response.dart';
import 'image_loader.dart';

class BidderInfo extends StatelessWidget {
  final OrderResponse order;
  const BidderInfo({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ImageLoader(
          imageUrl: order.user?.imageUrl,
          height: size.height * 0.1,
          width: size.width * 0.2,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(order.user?.fullName ?? "No user information"),
              Text(order.user?.city ?? "No user information"),
            ],
          ),
        )
      ],
    );
  }
}
