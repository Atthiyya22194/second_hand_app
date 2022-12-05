import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/models/product_response.dart';
import 'package:second_hand_app/widgets/show_loading.dart';
import 'package:second_hand_app/widgets/show_snack_bar.dart';

import '../../bloc/home_page/home_page_bloc.dart';
import '../../bloc/home_page/home_page_events.dart';
import '../../bloc/home_page/home_page_states.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/product_card.dart';

class HomePage extends StatelessWidget {
  static const routName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(
        MarketRepository(),
      )..add(
          LoadHomePageEvent(),
        ),
      child: Scaffold(
        body: BlocConsumer<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is HomePageLoadingState) {
              return const ShowLoading();
            }

            if (state is HomePageLoadedState) {
              List<ProductResponse> data = state.products;
              return HomePageContent(data: data);
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Something went wrong...'),
                  ],
                ),
              ],
            );
          },
          listener: (context, state) {
            if (state is HomePageErrorState) {
              showSnackBar(context, 'Something went wrong', state.error,
                  ContentType.failure);
            }
          },
        ),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  final List<ProductResponse> data;
  const HomePageContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              final product = data[index];
              return ProductCard(product: product);
            },
          ),
        )
      ],
    );
  }
}
