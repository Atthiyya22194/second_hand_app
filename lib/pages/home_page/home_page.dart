import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_page/home_page_bloc.dart';
import '../../bloc/home_page/home_page_events.dart';
import '../../bloc/home_page/home_page_states.dart';
import '../../models/product_response.dart';
import '../../repositories/market_repository.dart';
import '../../widgets/poppins_text.dart';
import '../../widgets/product_card.dart';
import '../../widgets/rounded_button.dart';
import '../../widgets/rounded_text_field.dart';
import '../../widgets/show_loading.dart';
import '../../widgets/show_snack_bar.dart';
import '../product_detail/product_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomePageBloc(MarketRepository()),
        child: const Content(),
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: const [
          HomeHeader(),
          CategoryList(),
          ProductList(),
        ],
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Color(0xffffffff)),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffffe9c9),
              Color(0xffffffff),
            ],
          ),
        ),
        child: Column(
          children: const [SearchBar(), HomeBanner()],
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
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      padding: EdgeInsets.fromLTRB(16 * fem, 0 * fem, 16 * fem, 0 * fem),
      child: RoundedTextField(
        hint: 'Search Product',
        title: '',
        controller: searchController,
        onSubmited: (text) {
          if (text.isNotEmpty) {
            BlocProvider.of<HomePageBloc>(context)
                .add(GetProducts(productName: text));
          }
        },
      ),
    );
  }
}

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
      padding: EdgeInsets.fromLTRB(16 * fem, 0 * fem, 16 * fem, 16 * fem),
      child: Row(
        children: [
          const Expanded(child: BannerItem1()),
          Expanded(child: Container())
        ],
      ),
    );
  }
}

class BannerItem1 extends StatelessWidget {
  const BannerItem1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        PoppinsText(
          text: 'Bulan Ramadhan Banyak Diskonnya!',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          height: 1.5,
        ),
        PoppinsText(
          text: 'Diskon hingga',
          fontSize: 10,
          fontWeight: FontWeight.w400,
        ),
        PoppinsText(
          text: '60%',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(0xfffa2c5a),
        )
      ],
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    var list = [
      'Elektronik',
      'Komputer dan Aksesoris',
      'Handphone dan Aksesoris',
      'Pakaian Pria',
      'Sepatu Pria',
      'Tas Pria',
      'Aksesoris Fashion',
      'Kesehatan',
      'Hobi dan Koleksi',
      'Makanan dan Minuman',
      'Perawatan dan Kecantikan',
      'Perlengkapan Rumah',
      'Pakaian Wanita',
      'Fashion Muslim',
      'Fashion bayi dan Anak',
      'Ibu dan Bayi',
      'Sepatu Wanita',
      'Tas Wanita',
      'Otomotif',
      'Olahraga dan Outdoor',
      'Buku dan Alat Tulis',
      'Voucher',
      'Souvenir dan Pesta',
      'Fotografi'
    ];

    return Container(
      padding: EdgeInsets.fromLTRB(16 * fem, 0 * fem, 16 * fem, 0 * fem),
      width: double.infinity,
      height: 45 * ffem,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (_, index) {
          final category = list[index];
          return Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 4 * fem, 8 * fem),
            child: RoundedButton(
              text: category,
              onPressed: () {
                final categoryId = list.indexOf(category) + 1;

                BlocProvider.of<HomePageBloc>(context).add(
                  GetProducts(
                    categoryId: categoryId.toString(),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return BlocConsumer<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is HomePageInitState) {
          BlocProvider.of<HomePageBloc>(context).add(GetProducts());
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
                return Container(
                  padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem, 16 * fem, 0),
                  child: ProductCard(
                    product: product,
                    route: ProductDetailpage(id: product.id.toString()),
                  ),
                );
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
