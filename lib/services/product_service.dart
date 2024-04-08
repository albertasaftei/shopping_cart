import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:shopping_cart/models/product_model.dart';

class ProductService {
  Future<List<Product>> getProducts() async {
    final response = await get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List<Product> products = [];

      for (var product in data) {
        products.add(Product.fromJson(product));
      }

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}

final asyncProductsProvider = FutureProvider<List<Product>>((ref) async {
  final products = await ProductService().getProducts();
  return products;
});
