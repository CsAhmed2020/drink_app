import 'package:flutter/material.dart';
import 'package:new_app/model/product_model.dart';
import 'package:new_app/widgets/product_card.dart';

class ProductCarousel extends StatelessWidget {
  final List<Product> products;

  const ProductCarousel({
    Key? key,
    required this.products
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        height: 165,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
            itemCount: products.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.only(right: 2.0,bottom: 10.0),
                child: ProductCard.catalog(
                    product: products[index])
              );
            }
        ),
      ),
    );
  }
}