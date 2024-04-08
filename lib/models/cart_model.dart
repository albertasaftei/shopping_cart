import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/models/product_model.dart';

class Cart {
  final List<Product> products;

  Cart({required this.products});
}

class CartNotifier extends ChangeNotifier {
  final Cart cart = Cart(products: []);

  void addToCart(Product product) {
    if (cart.products.any((element) => element.id == product.id)) {
      incrementQuantity(product.id);
      return;
    } else {
      cart.products.add(product);
    }
    notifyListeners();
  }

  int totalQuantityProducts() {
    int total = 0;
    for (var product in cart.products) {
      total += product.quantity;
    }

    return total;
  }

  double totalAmount() {
    double total = 0;
    for (var product in cart.products) {
      total += product.price * product.quantity;
    }

    return total;
  }

  void remove(int id) {
    cart.products.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void incrementQuantity(int id) {
    final int index = cart.products.indexWhere((element) => element.id == id);
    cart.products[index].quantity += 1;

    notifyListeners();
  }

  void decrementQuantity(int id) {
    final int index = cart.products.indexWhere((element) => element.id == id);

    if (cart.products[index].quantity > 1) {
      cart.products[index].quantity -= 1;
    } else {
      remove(id);
    }

    notifyListeners();
  }
}

final cartProvider =
    ChangeNotifierProvider<CartNotifier>((ref) => CartNotifier());
