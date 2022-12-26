import 'package:flutter/material.dart';
import 'package:second_hand_app/pages/product_detail/product_detail_page.dart';
import 'package:second_hand_app/widgets/poppins_text.dart';

import '../models/product_response.dart';
import 'image_loader.dart';

class ProductCard extends StatelessWidget {
  final ProductResponse product;
  final Widget route;

  const ProductCard({Key? key, required this.product, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return GestureDetector(
      onTap: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(builder: (context) {
          return route;
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
                      imageUrl: product.imageUrl,
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
                        text: product.name,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 4 * fem),
                      child: PoppinsText(
                        text: "Rp. ${product.basePrice}",
                      ),
                    ),
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
}
