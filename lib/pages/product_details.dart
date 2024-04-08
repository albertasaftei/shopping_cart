import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/components/appBar.dart';
import 'package:shopping_cart/components/cartIcon.dart';
import 'package:shopping_cart/models/cart_model.dart';
import 'package:shopping_cart/models/product_model.dart';
import 'package:shopping_cart/services/product_service.dart';

class ProductDetails extends ConsumerWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MyAppBar(
        title: const Text(
          'Product details',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        showBackArrow: true,
        backArrowColor: Colors.white,
        actions: [
          shoppingCartIcon(context, ref),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              product.image,
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 10),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${product.price}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                ref.read(cartProvider.notifier).addToCart(product);
              },
              child: const Text('Add to cart'),
            ),
          ],
        ),
      ),
    );
  }
}
