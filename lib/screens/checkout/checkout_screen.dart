
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/blocs/checkout/checkout_bloc.dart';
import 'package:new_app/blocs/checkout/checkout_event.dart';
import 'package:new_app/blocs/checkout/checkout_state.dart';
import 'package:new_app/widgets/custom_text_form_field.dart';
import 'package:new_app/widgets/widgets.dart';

class CheckoutScreen extends StatelessWidget {
  static const String routeName = '/checkout';

  static Route route(){
    return MaterialPageRoute(
        settings: RouteSettings(name:routeName),
        builder: (context) => CheckoutScreen()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Checkout'),
      bottomNavigationBar: const CustomNavBar(screen:routeName),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<CheckoutBloc,CheckoutState>(
          builder: (context, state) {
            if (state is CheckoutLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CheckoutLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer Information',
                      style: Theme.of(context).textTheme.headline3
                  ),
                  CustomTextFormField(
                    title: 'Full Name',
                    onChanged: (value){
                      context.read<CheckoutBloc>().add(
                          UpdateCheckout(fullName: value)
                      );
                    },
                  ),

                  CustomTextFormField(
                    title: 'Email',
                    onChanged: (value){
                      context.read<CheckoutBloc>().add(
                          UpdateCheckout(email: value)
                      );
                    },
                  ),

                  Text('Delivery Information',
                      style: Theme.of(context).textTheme.headline3
                  ),

                  CustomTextFormField(
                    title: 'Address',
                    onChanged: (value){
                      context.read<CheckoutBloc>().add(
                          UpdateCheckout(address: value)
                      );
                    },
                  ),

                  CustomTextFormField(
                    title: 'City',
                    onChanged: (value){
                      context.read<CheckoutBloc>().add(
                          UpdateCheckout(city: value)
                      );
                    },
                  ),

                  CustomTextFormField(
                    title: 'Country',
                    onChanged: (value){
                      context.read<CheckoutBloc>().add(
                          UpdateCheckout(country: value)
                      );
                    },
                  ),

                  CustomTextFormField(
                    title: 'Zip Code',
                    onChanged: (value){
                      context.read<CheckoutBloc>().add(
                          UpdateCheckout(zipCode: value)
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  Container(
                    height: 60,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/payment-selection',
                              );
                            },
                            child: Text(
                              'SELECT A PAYMENT METHOD',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  Text('Order Summary',
                      style: Theme.of(context).textTheme.headline3
                  ),
                  const OrderSummary()
                ],
              );
            }
            else {
              return const Text('Something went wrong');
            }
          }
        ),
      ),
    );
  }

}