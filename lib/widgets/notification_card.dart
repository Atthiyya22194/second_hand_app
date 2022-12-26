import 'package:flutter/material.dart';
import 'package:second_hand_app/pages/offer_detail_page/offer_detail_page.dart';
import 'package:second_hand_app/pages/product_detail/product_detail_page.dart';
import '../pages/my_product_detail_page/my_product_detail_page.dart';
import 'image_loader.dart';
import 'poppins_text.dart';

import '../models/notification_response.dart';

class NotificationCard extends StatelessWidget {
  final NotificationResponse notification;

  const NotificationCard({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return GestureDetector(
      onTap: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) {
          return _navigation(notification.status);
        }),
      ),
      child: Container(
        margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 8 * fem),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 16 * fem, 0 * fem),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12 * fem),
                    child: ImageLoader(
                      height: 70 * fem,
                      width: 70 * fem,
                      imageUrl: notification.product.imageUrl,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 4 * fem),
                        child: PoppinsText(
                          text: _statusChecker(notification.status),
                          color: const Color(0xff8a8a8a),
                          fontSize: 13,
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 4 * fem),
                      child: PoppinsText(
                        text: notification.productName,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 4 * fem),
                      child: PoppinsText(
                        text: "Rp. ${notification.basePrice}",
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 8 * fem),
                      child: (notification.orderId == null)
                          ? Container()
                          : PoppinsText(
                              text: "Ditawar ${notification.bidPrice}",
                            ),
                    )
                  ],
                )
              ],
            ),
            Divider(
              color: const Color(0xffe5e5e5),
              thickness: 1 * fem,
            )
          ],
        ),
      ),
    );
  }

  String _statusChecker(String status) {
    if (status == "create") {
      return 'Produk diupload';
    } else if (status == "bid") {
      return "Produk ditawar";
    } else if (status == "accepted") {
      return "Penawaran diterima";
    } else if (status == "declined") {
      return "Penawaran ditolak";
    } else {
      return "Something went wrong";
    }
  }

  _navigation(String status) {
    if (status == "create") {
      return MyProductDetailPage(id: notification.productId.toString());
    } else if (status == "bid") {
      return OfferDetailPage(orderId: notification.orderId.toString());
    } else if (status == "accepted") {
      return ProductDetailpage(id: notification.productId.toString());
    } else if (status == "declined") {
      return ProductDetailpage(id: notification.productId.toString());
    } else {
      return null;
    }
  }
}
