import 'package:flutter/material.dart';
import '../models/product_response.dart';

import '../pages/product_detail/product_detail_page.dart';

class ProductCard extends StatelessWidget {
  final ProductResponse product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: 'product ${product.id}',
          child: Image.network(
            product.imageUrl,
            width: 100,
          ),
        ),
        title: Text(
          product.name,
        ),
        subtitle: Text(product.basePrice.toString()),
        onTap: () => Navigator.of(context, rootNavigator: true).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailpage(id: product.id.toString()),
          ),
        ),
      ),
    );
  }
}
