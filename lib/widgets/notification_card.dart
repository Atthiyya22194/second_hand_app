import 'package:flutter/material.dart';
import 'package:second_hand_app/pages/my_product_detail_page/my_product_detail_page.dart';
import 'package:second_hand_app/widgets/image_loader.dart';
import 'package:second_hand_app/widgets/poppins_text.dart';

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
        MaterialPageRoute(
          builder: (context) =>
              MyProductDetailPage(id: notification.product.id.toString()),
        ),
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
                        child: (notification.orderId == null)
                            ? const PoppinsText(
                                text: 'Upload Product',
                                color: Color(0xff8a8a8a),
                                fontSize: 13,
                              )
                            : const PoppinsText(
                                text: 'Penawaran produk',
                                color: Color(0xff8a8a8a),
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
    // return Material(
    //   child: ListTile(
    //     contentPadding:
    //         const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    //     leading: Hero(
    //       tag: 'notification image',
    //       child: Image.network(
    //         notification.imageUrl,
    //         width: 100,
    //       ),
    //     ),
    //     title: Text(
    //       notification.productName,
    //     ),
    //     subtitle: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(bottom: 8.0),
    //           child: Text("Base Price.${notification.basePrice.toString()}"),
    //         ),
    //         Text("Bid Price ${notification.basePrice}")
    //       ],
    //     ),
    //     onTap: () => Navigator.of(context, rootNavigator: true).push(
    //       MaterialPageRoute(
    //         builder: (context) =>
    //             ProductDetailpage(id: notification.id.toString()),
    //       ),
    //     ),
    //   ),
    // );
  }
}
