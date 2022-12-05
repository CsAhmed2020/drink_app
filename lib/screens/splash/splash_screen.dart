
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_app/widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => SplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Timer(
    const Duration(seconds: 1),
            () => Navigator.pushNamed(context, '/'),
    );
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Image(
                image: AssetImage('assets/images/logo.png'),
            width: 150,height: 150
            ),
          ),
          const SizedBox(height: 30),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20
            ),
            child: Text(
              'Drink App',
              style: Theme.of(context).textTheme.headline2!
              .copyWith(color: Colors.white)
            ),
          )
        ],
      ),
    );
  }

}