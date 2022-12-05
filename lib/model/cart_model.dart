
import 'package:equatable/equatable.dart';
import 'package:new_app/model/product_model.dart';

class Cart extends Equatable{
  final List<Product> products;

  const Cart({this.products = const <Product>[]});

  @override
  List<Object?> get props => [products];

  Map productQuantity(products) {
    var quantity = Map();
    products.forEach((product){
      if(!quantity.containsKey(product)){
        quantity[product] = 1;
      }else {
        quantity[product] +=1;
      }
    });
    return quantity;
  }
  double get subtotal =>
      products.fold(0,(total , current) => total + current.price);

  double deliveryFee(subtotal){
    if (subtotal >= 50){
      return 5.0;
    }else{
      return 7.0;
    }
  }

  String freeDelivery(subtotal){
    if(subtotal >=50){
      return 'You have a free delivery' ;
    }else {
      double missing = 50.0 - subtotal;
      return 'Add ${missing.toStringAsFixed(2)} L.E to get a free delivery';
    }
  }

  double get total => subtotal + deliveryFee(subtotal);

  String get subtotalString => subtotal.toStringAsFixed(2);

  String get deliveryFeeString => deliveryFee(subtotal).toStringAsFixed(2);

  String get freeDeliveryString => freeDelivery(subtotal);

  String get totalString => total.toStringAsFixed(2);




  /*
     List<Product> products = [
  const Product(
  /*id: '1',*/
  name: 'Soft Drink #1',
  category: 'Soft Drinks',
  imageUrl:
  'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/dO9A6mhSZZY
  price: 2.99,
  isRecommended: true,
  isPopular: false,
  ),
  const Product(
  /*id: '2',*/
  name: 'Soft Drink #2',
  category: 'Soft Drinks',
  imageUrl:
  'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80', //https://unsplash.com/photos/Viy_8zHEznk
  price: 2.99,
  isRecommended: false,
  isPopular: true,
  ),
  const Product(
  /* id: '3',*/
  name: 'Soft Drink #3',
  category: 'Soft Drinks',
  imageUrl:
  'https://images.unsplash.com/photo-1603833797131-3c0a18fcb6b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/5LIInaqRp5s
  price: 2.99,
  isRecommended: true,
  isPopular: true,
  ),
  const Product(
  /*id: '4',*/
  name: 'Smoothies #1',
  category: 'Smoothies',
  imageUrl:
  'https://images.unsplash.com/photo-1526424382096-74a93e105682?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80', //https://unsplash.com/photos/kcYXj4tBtes
  price: 2.99,
  isRecommended: true,
  isPopular: false,
  ),
     const Product(
       /*id: '5',*/
       name: 'Smoothies #2',
       category: 'Smoothies',
       imageUrl:
       'https://images.unsplash.com/photo-1505252585461-04db1eb84625?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1552&q=80', //https://unsplash.com/photos/CrK843Pl9a4
       price: 2.99,
       isRecommended: false,
       isPopular: false,
     ),
     const Product(
       /*id: '6',*/
       name: 'Soft Drink #1',
       category: 'Soft Drinks',
       imageUrl:
       'https://images.unsplash.com/photo-1598614187854-26a60e982dc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/dO9A6mhSZZY
       price: 2.99,
       isRecommended: true,
       isPopular: false,
     ),
     const Product(
       /*id: '7',*/
       name: 'Soft Drink #2',
       category: 'Soft Drinks',
       imageUrl:
       'https://images.unsplash.com/photo-1610873167013-2dd675d30ef4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=488&q=80', //https://unsplash.com/photos/Viy_8zHEznk
       price: 2.99,
       isRecommended: false,
       isPopular: true,
     ),
     const Product(
       /*id: '8',*/
       name: 'Soft Drink #3',
       category: 'Soft Drinks',
       imageUrl:
       'https://images.unsplash.com/photo-1603833797131-3c0a18fcb6b1?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80', //https://unsplash.com/photos/5LIInaqRp5s
       price: 2.99,
       isRecommended: true,
       isPopular: true,
     ),
  ];
   */

}