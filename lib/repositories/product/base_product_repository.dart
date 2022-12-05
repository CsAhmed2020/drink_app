import '../../model/product_model.dart';

abstract class BaseProductRepository {
  Stream<List<Product>> getAllProducts();
}