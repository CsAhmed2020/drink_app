
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/model/models.dart';
import 'package:new_app/widgets/widgets.dart';

import '../../blocs/product/product_bloc.dart';
import '../../blocs/product/product_state.dart';


class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';

  static Route route({required Category category}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => CatalogScreen(category: category),
    );
  }

  final Category category;
  const CatalogScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: category.name),
      bottomNavigationBar: const CustomNavBar(screen: routeName),
      body: BlocBuilder<ProductBloc,ProductState>(
          builder: (context, state) {
            if(state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductLoaded) {
              final List<Product> categoryProducts = state.products
              .where((product) => product.category == category.name).toList();
              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 1),
                  itemCount: categoryProducts.length,
                  itemBuilder: (BuildContext context , int index){
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: ProductCard.catalog(
                            product: categoryProducts[index]
                        ),
                      ),
                    );
                  },
              );
            }
            else {
              return const Text('Something went wrong');
            }

          }
      ),

    );
  }

}