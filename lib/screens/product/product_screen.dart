

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/blocs/cart/Cart_state.dart';
import 'package:new_app/blocs/cart/cart_bloc.dart';
import 'package:new_app/blocs/cart/cart_event.dart';
import 'package:new_app/blocs/wishlist/wishlist_bloc.dart';

import '../../model/product_model.dart';
import '../../widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/product';

  static Route route({required Product product}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => ProductScreen(product: product),
    );
  }

  final Product product;

  const ProductScreen({
    required this.product
});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: product.name),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.share,color: Colors.white)),
              BlocBuilder<WishlistBloc,WishlistState>(
                builder: (context,state) {
                  return IconButton(
                      onPressed: (){
                        context.read<WishlistBloc>()
                            .add(AddProductToWishlist(product));

                        const snackBar = SnackBar(content: Text('Added to your Wishlist!'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: const Icon(Icons.favorite,color: Colors.white)
                  );
                }
              ),
              BlocBuilder<CartBloc,CartState>(
                builder: (context, state) {
                  return ElevatedButton(onPressed: (){
                    context.read<CartBloc>()
                        .add(AddProduct(product));
                    Navigator.pushNamed(context, '/cart');
                  },
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      child: Text(
                        'Add To Cart',
                        style: Theme.of(context).textTheme.headline3
                      ));
                }
              )
            ],
          ),
        ),
      ),
      body: ListView(
        children:[
          CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 1.5,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height, //reduce the space between cards
          ),
          items:[
            HeroCarouselCard(product: product)
          ],
        ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.bottomCenter,
                  color: Colors.black.withAlpha(50),
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 50,
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(
                      product.name,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!.copyWith(color: Colors.white)
                    ),
                        Text(
                    '${product.price} L.E',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!.copyWith(color: Colors.white)
                )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20.0),
             child: ExpansionTile(
              initiallyExpanded: false,
                title: Text('Product Information',
                    style: Theme.of(context)
                        .textTheme
                        .headline3),
               children: [
                 ListTile(
                   title: Text(
                     'csahmed.98.20@gmail.com csahmed.98.20@gmail.com csahmed.98.20@gmail.com csahmed.98.20@gmail.com csahmed.98.20@gmail.com',
                       style: Theme.of(context)
                           .textTheme.bodyText1
                   ),
                 )
               ],
          ),
           ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              initiallyExpanded: false,
              title: Text('Delivery Information',
                  style: Theme.of(context)
                      .textTheme
                      .headline3),
              children: [
                ListTile(
                  title: Text(
                      'csahmed.98.20@gmail.com  csahmed.98.20@gmail.com csahmed.98.20@gmail.com csahmed.98.20@gmail.com csahmed.98.20@gmail.com csahmed.98.20@gmail.com',
                      style: Theme.of(context)
                          .textTheme.bodyText1
                  ),
                )
              ],
            ),
          ),
      ],
      ),
    );
  }

}