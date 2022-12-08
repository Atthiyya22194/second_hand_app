import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/bloc/notification/notification_page_bloc.dart';

import 'package:second_hand_app/pages/notification/seller/seller_notification_page.dart';
import 'package:second_hand_app/repositories/market_repository.dart';

import '../../widgets/notification_type.dart';
import 'buyer/buyer_notification_page.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => NotificationBloc(MarketRepository()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            NotificationType(
              type: "Buyer Notification",
              page: BuyerNotificationList(),
            ),
            NotificationType(
              type: "Seller Notification",
              page: SellerNotificationList(),
            )
          ],
        ),
      ),
    );
  }
}
