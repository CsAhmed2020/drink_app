import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/blocs/category/category_bloc.dart';
import 'package:new_app/blocs/product/product_bloc.dart';
import 'package:new_app/blocs/product/product_state.dart';
import 'package:new_app/widgets/widgets.dart';

import '../../blocs/category/category_state.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeScreen(),
    );
  }
  @override
  Widget build(BuildContext context){
    return   Scaffold(
      appBar: const CustomAppBar(title: 'Drink App'),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CategoryBloc,CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CategoryLoaded) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1.5,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height, //reduce the space between cards
                    ),
                    items: state.categories
                        .map((category) => HeroCarouselCard(category:category))
                        .toList(),
                  );
                }
                else {
                  return const Text('Something went wrong');
                }

              }
            ),
            const TitleSection(title: "Recommended"),
            BlocBuilder<ProductBloc,ProductState>(
              builder: (context, state) {
                if(state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductLoaded) {
                  return ProductCarousel(
                      products:state.products
                      .where((product) => product.isRecommended).toList()
                  );
                }
                else {
                  return const Text('Something went wrong');
                }

              }
            ),
            const TitleSection(title: "Most Popular"),
            BlocBuilder<ProductBloc,ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ProductLoaded) {
                  return ProductCarousel(products:state.products
                      .where((product) => product.isPopular).toList()
                  );
                }
                else {
                  return const Text('Something went wrong');
                }
              }
            )
          ],
        ),
      ),
    );
  }
}





