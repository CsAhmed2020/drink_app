import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/blocs/payment/payment_event.dart';
import 'blocs/blocs.dart';
import 'package:new_app/blocs/cart/cart_event.dart';
import 'package:new_app/blocs/category/category_event.dart';
import 'package:new_app/blocs/product/product_event.dart';
import 'package:new_app/config/theme.dart';
import 'package:new_app/repositories/repositories.dart';
import 'package:new_app/screens/screens.dart';
import 'package:new_app/simple_bloc_observer.dart';
import 'config/app_router.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  BlocOverrides.runZoned(
          () {
    runApp(const MyApp());
  },
  blocObserver: SimpleBlocObserver()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WishlistBloc()..add(LoadWishlist())),
        BlocProvider(create: (_) => CartBloc()..add(LoadCart())),
        BlocProvider(create: (_) => PaymentBloc()..add(LoadPaymentMethod())),
        BlocProvider(create: (context) => CheckoutBloc(
            cartBloc: context.read<CartBloc>(),
            paymentBloc: context.read<PaymentBloc>(),
            checkoutRepository: CheckoutRepository()
        )),
        BlocProvider( create: (_) => CategoryBloc(
                categoryRepository: CategoryRepository(),
            )..add(LoadCategories()),),
        BlocProvider(create: (_) => ProductBloc(productRepository:ProductRepository(),)..add(LoadProducts()),
        ),

      ],
        child: MaterialApp(
          title: 'Drink App',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName
        ),
    );
  }
}




