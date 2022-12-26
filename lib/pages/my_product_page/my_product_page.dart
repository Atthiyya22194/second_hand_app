import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/poppins_text.dart';
import 'completed/completed_order_page.dart';
import 'declined/declined_order_page.dart';
import 'pending/pending_order_page.dart';
import 'product_list/product_list_page.dart';

class MyProductPage extends StatelessWidget {
  const MyProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavBar(),
              ),
            );
          },
        ),
        title: const PoppinsText(
          text: 'My Product',
          fontWeight: FontWeight.w700,
          fontSize: 20,
          height: 1.5,
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(24 * fem, 16 * fem, 24 * fem, 8 * fem),
        child: const ButtonTab(),
      ),
    );
  }
}

class ButtonTab extends StatelessWidget {
  const ButtonTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          ButtonsTabBar(
            backgroundColor: const Color(0xff7126b5),
            unselectedBackgroundColor: Colors.white,
            labelStyle: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(
                color: Color(0xff7126b5), fontWeight: FontWeight.bold),
            borderWidth: 1,
            borderColor: const Color(0xff7126b5),
            unselectedBorderColor: const Color(0xff7126b5),
            radius: 10,
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
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 16 * fem, 0, 0),
              child: TabBarView(
                children: [
                  MyProductListPage(),
                  PendingOrderPage(),
                  CompletedOrderPage(),
                  DeclinedOrderPage()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
