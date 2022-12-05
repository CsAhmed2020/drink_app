
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/blocs/cart/cart_bloc.dart';
import 'package:new_app/widgets/widgets.dart';

import '../../blocs/cart/Cart_state.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  static Route route(){
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) => CartScreen()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Cart'),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/checkout');
              },
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  child: Text(
                      'Go To CheckOut',
                      style: Theme.of(context).textTheme.headline3
                  )
              )
            ],
          ),
        ),
      ),
      body: BlocBuilder<CartBloc,CartState>(
        builder: (context,state) {
          if(state is CartLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CartLoaded){
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,vertical: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                               state.cart.freeDeliveryString,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            ElevatedButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/');
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    shape: const RoundedRectangleBorder(),
                                    elevation: 0
                                ),
                                child: Text(
                                  'Add More',
                                  style: Theme.of(context).textTheme.headline6!
                                      .copyWith(color: Colors.white),
                                )
                            )
                          ],
                        ),

                        const SizedBox(height: 10),
                        SizedBox(
                          height: 400,
                          child: ListView.builder(
                            itemCount: state.cart.productQuantity(state.cart.products)
                            .keys.length,
                            itemBuilder: (context,index){
                              return CartProductCard(
                                  product:state.cart
                                  .productQuantity(state.cart.products)
                                  .keys
                                  .elementAt(index),
                                  quantity:state.cart
                                  .productQuantity(state.cart.products)
                                  .values
                                  .elementAt(index)
                              );
                            },
                          ),
                        )
                      ],
                    ),
                    const OrderSummary()
                  ],
                ),
              ),
            );
          }
          else {
            return const Text('Something went wrong');
          }
        },
      )
    );
  }

}

