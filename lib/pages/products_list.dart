import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/components/cartIcon.dart';
import 'package:shopping_cart/models/product_model.dart';
import 'package:shopping_cart/pages/cart_details.dart';
import 'package:shopping_cart/models/cart_model.dart';
import 'package:shopping_cart/pages/product_details.dart';
import 'package:shopping_cart/services/product_service.dart';
import 'package:gap/gap.dart';
import 'package:badges/badges.dart' as badges;

class ShoppingCart extends ConsumerStatefulWidget {
  const ShoppingCart({super.key});

  @override
  ConsumerState<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends ConsumerState<ShoppingCart> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            futureProducts = ProductService().getProducts();
          });
        },
        child: FutureBuilder<List<Product>>(
            future: futureProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent,
                  ),
                );
              }

              if (snapshot.hasData) {
                return GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 5,
                  childAspectRatio: 125 / 200,
                  children: List.generate(snapshot.data!.length, (index) {
                    Product product = snapshot.data![index];
                    return _productCard(product);
                  }),
                );
              }
              return const Text('No data');
            }),
      ),
    );
  }

  Widget _productCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Image.network(
                product.image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 12),
                  ),
                  Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      for (var i = 0; i < 5; i++)
                        Icon(
                          i < product.rating['rate']
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 15,
                        ),
                    ],
                  ),
                  const Gap(10),
                  Text(
                    product.price.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  const Gap(10),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addToCart(product);
                    },
                    child: const Text('Add to cart'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      toolbarHeight: 50,
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: const Text(
        'Shopping Cart',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      actions: [
        shoppingCartIcon(context, ref),
      ],
    );
  }
}
