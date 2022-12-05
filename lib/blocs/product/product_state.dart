
import 'package:equatable/equatable.dart';
import 'package:new_app/model/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded({this.products = const <Product>[]});

  @override
  List<Object> get props => [products];
}