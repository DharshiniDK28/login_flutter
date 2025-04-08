
import '../models/product_model.dart';
import 'package:flutter_application_7/data/services/product_services.dart';

class ProductRepository {
  final ProductService productService;

  ProductRepository({required this.productService});

  Future<List<Product>> getProducts() async {
    return await productService.fetchProducts();
  }
}
