import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/my_product/my_product_bloc.dart';
import '../../../bloc/my_product/my_product_event.dart';
import '../../../bloc/my_product/my_product_state.dart';
import '../../../models/product_response.dart';
import '../../../repositories/market_repository.dart';
import '../../../widgets/product_card.dart';
import '../../../widgets/show_loading.dart';
import '../../../widgets/show_snack_bar.dart';

class MyProductListPage extends StatelessWidget {
  const MyProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyProductBloc(MarketRepository())..add(GetMyProduct()),
      child: Scaffold(
        body: BlocConsumer<MyProductBloc, MyProductState>(
          builder: (context, state) {
            if (state is MyProductLoadingState) {
              return const ShowLoading();
            }

            if (state is MyProductLoadedState) {
              List<ProductResponse> data = state.products;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index) {
                  final product = data[index];
                  return ProductCard(product: product);
                },
              );
            }

            return Container();
          },
          listener: (context, state) {
            if (state is MyProductErrorState) {
              showSnackBar(context, 'Something went wrong', state.error,
                  ContentType.failure);
            }
          },
        ),
      ),
    );
  }
}
