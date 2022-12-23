import 'package:flutter/material.dart';

import '../models/product_detail_response.dart';

class RoundedBorderContainer extends StatelessWidget {
  const RoundedBorderContainer({
    Key? key,
    required this.product,
    required this.child,
  }) : super(key: key);

  final ProductDetailResponse product;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      margin: EdgeInsets.fromLTRB(16 * ffem, 8 * ffem, 16 * ffem, 16 * ffem),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16 * fem),
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x26000000),
            offset: Offset(0 * fem, 0 * fem),
            blurRadius: 2 * fem,
          ),
        ],
      ),
      child: Container(
          padding:
              EdgeInsets.fromLTRB(16 * ffem, 16 * ffem, 16 * ffem, 16 * ffem),
          child: child),
    );
  }
}