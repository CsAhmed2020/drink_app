
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/blocs/cart/Cart_state.dart';
import 'package:new_app/blocs/cart/cart_bloc.dart';
import 'package:new_app/blocs/cart/cart_event.dart';

import '../model/product_model.dart';

class CartProductCard extends StatelessWidget {
  final Product product;
  final int quantity ;

  const CartProductCard({
    Key? key,
    required this.product,
    required this.quantity
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Wrap(
        children: [
          Image.network(
            product.imageUrl,
            width: 100,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  '${product.price} L.E',
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          BlocBuilder<CartBloc,CartState>(
            builder: (context, state) {
              if(state is CartLoading){
                return const CircularProgressIndicator();
              }
              if (state is CartLoaded) {
                return Row(
                  children: [
                    IconButton(onPressed: (){
                      context.read<CartBloc>()
                          .add(RemoveProduct(product));
                    },
                        icon: const Icon(Icons.remove_circle,
                            color: Colors.black)
                    ),
                    Text(
                      '$quantity',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    IconButton(onPressed: (){
                      context.read<CartBloc>()
                          .add(AddProduct(product));
                    },
                        icon: const Icon(Icons.add_circle,
                            color: Colors.black)
                    ),
                  ],
                );
              }
              return const Text('something went wrong');
            }
          )
        ],
      ),
    );
  }
}