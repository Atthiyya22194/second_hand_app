import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_hand_app/models/product_response.dart';

import '../../bloc/home_page/home_page_bloc.dart';
import '../../bloc/home_page/home_page_events.dart';
import '../../bloc/home_page/home_page_states.dart';
import '../../repositories/home_page_repository.dart';
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
        body: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            if (state is HomePageLoadingState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      Text('Loading...'),
                    ],
                  ),
                ],
              );
            }

            if (state is HomePageLoadedState) {
              List<ProductResponse> data = state.products;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index) {
                  final product = data[index];
                  return ProductCard(product: product);
                },
              );
            }

            if (state is HomePageErrorState) {
              return Center(
                child: Text(state.error),
              );
            }

            return const Center(
              child: Text('List is empty'),
            );
          },
        ),
      ),
    );
  }
}
