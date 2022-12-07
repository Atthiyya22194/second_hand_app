import 'package:flutter/material.dart';
import 'package:second_hand_app/models/notification_response.dart';

import '../pages/product_detail/product_detail_page.dart';

class NotificationCard extends StatelessWidget {
  final NotificationResponse notification;

  const NotificationCard({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Image.network(
          notification.imageUrl,
          width: 100,
        ),
        title: Text(
          notification.productName,
        ),
        subtitle: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text("Base Price.${notification.basePrice.toString()}"),
            ),
            Text("Bid Price ${notification.basePrice}")
          ],
        ),
        onTap: () => Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailpage(id: notification.id.toString()),
          ),
        ),
      ),
    );
  }
}
