import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/product_response.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';

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
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<HomePageBloc>(
              create: (context) => HomePageBloc(MarketRepository()))
        ],
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: const [SearchBar(), ProductList()],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: TextField(
        controller: searchController,
        decoration: const InputDecoration(labelText: 'Search Product'),
        onChanged: (text) {
          if (text.isNotEmpty) {
            BlocProvider.of<HomePageBloc>(context).add(GetProducts(text));
          }
        },
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is HomePageInitState) {
          BlocProvider.of<HomePageBloc>(context).add(GetProducts(""));
        }
        if (state is HomePageLoadingState) {
          return const ShowLoading();
        }

        if (state is HomePageLoadedState) {
          List<ProductResponse> data = state.products;
          return Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (_, index) {
                final product = data[index];
                return ProductCard(product: product);
              },
            ),
          );
        }

        return Container();
      },
      listener: (context, state) {
        if (state is HomePageErrorState) {
          showSnackBar(context, 'Something went wrong', state.error,
              ContentType.failure);
        }
      },
    );
  }
}
