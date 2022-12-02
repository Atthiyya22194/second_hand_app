import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/models/product_detail_response.dart';

import '../../bloc/product_detail/product_detail_page_bloc.dart';
import '../../bloc/product_detail/product_detail_page_events.dart';
import '../../bloc/product_detail/product_detail_page_states.dart';
import '../../repositories/product_detail_page_repository.dart';

class ProductDetailpage extends StatelessWidget {
  final String id;
  const ProductDetailpage({Key? key, required this.id})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailBloc(ProductDetailPageRepository(), id)
        ..add(LoadProductDetailPageEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detail'),
        ),
        body: BlocBuilder<ProductDetailBloc, ProductDetailPageState>(
          builder: (context, state) {
            if (state is ProductDetailPageLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProductDetailPageLoadedState) {
              final ProductDetailResponse product = state.products;
              return Content(
                product: product,
              );
            }

            if (state is ProductDetailPageErrorState) {
              return Center(child: Text(state.error));
            }

            return const Center(child: Text('List is empty'));
          },
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final ProductDetailResponse product;
  const Content({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageLoader(product: product),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(product.name), Text(product.basePrice.toString())],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.user?.fullName ?? "No user information"),
              Text(product.user?.city ?? "No user information")
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [const Text('Description'), Text(product.description)],
          ),
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("Start Bargain"),
          ),
        ),
      ],
    );
  }
}

class ImageLoader extends StatelessWidget {
  final ProductDetailResponse product;
  const ImageLoader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <CachedNetworkImage>[
        CachedNetworkImage(
          imageUrl: product.imageUrl,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              const Text('Loading image...'),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.fill,
        )
      ],
    );
  }
}

