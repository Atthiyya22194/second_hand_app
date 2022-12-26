import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/poppins_text.dart';

import '../../bloc/notification/notification_page_bloc.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/list_menu.dart';
import 'buyer/buyer_notification_page.dart';
import 'seller/seller_notification_page.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => NotificationBloc(MarketRepository()),
          child: Container(
            margin: EdgeInsets.fromLTRB(24 * fem, 16 * fem, 24 * fem, 8 * fem),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                PoppinsText(
                  text: 'Notification',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  height: 1.5,
                ),
                ListMenu(
                  icon: CupertinoIcons.person,
                  title: "Buyer Notification",
                  page: BuyerNotificationList(),
                ),
                ListMenu(
                  icon: CupertinoIcons.person_2,
                  title: "Seller Notification",
                  page: SellerNotificationList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
