import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_hand_app/pages/my_product_page/completed/completed_order_page.dart';
import 'package:second_hand_app/pages/my_product_page/declined/declined_order_page.dart';
import 'package:second_hand_app/pages/my_product_page/pending/pending_order_page.dart';
import 'package:second_hand_app/pages/my_product_page/product_list/product_list_page.dart';

class MyProductPage extends StatelessWidget {
  const MyProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            ButtonsTabBar(
              backgroundColor: Colors.blue[600],
              unselectedBackgroundColor: Colors.white,
              labelStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              unselectedLabelStyle: TextStyle(
                  color: Colors.blue[600], fontWeight: FontWeight.bold),
              borderWidth: 1,
              borderColor: Colors.blue,
              unselectedBorderColor: Colors.blue,
              radius: 100,
              tabs: const [
                Tab(
                  icon: Icon(CupertinoIcons.cube_box_fill),
                  text: 'My Product',
                ),
                Tab(
                  icon: Icon(CupertinoIcons.cart_fill),
                  text: 'Pending Order',
                ),
                Tab(
                  icon: Icon(CupertinoIcons.checkmark_seal_fill),
                  text: 'Completed Order',
                ),
                Tab(
                  icon: Icon(CupertinoIcons.xmark_seal_fill),
                  text: 'Decilned Order',
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  MyProductListPage(),
                  PendingOrderPage(),
                  CompletedOrderPage(),
                  DeclinedOrderPage()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
