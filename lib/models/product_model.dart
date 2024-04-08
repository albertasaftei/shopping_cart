import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Map<String, dynamic> rating;
  int quantity;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating,
      this.quantity = 1});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating'],
    );
  }
}

class ProductNotifier extends ChangeNotifier {
  final List<Product> products = [];

  Product getProductById(int id) {
    return products.firstWhere((element) => element.id == id);
  }
}

final productsProvider = ChangeNotifierProvider((ref) => ProductNotifier());
