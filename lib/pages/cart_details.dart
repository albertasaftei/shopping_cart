import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:shopping_cart/components/appBar.dart';
import 'package:shopping_cart/models/cart_model.dart';
import 'package:shopping_cart/models/product_model.dart';

class CartDetails extends ConsumerWidget {
  const CartDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Cart cart = ref.watch(cartProvider).cart;

    return Scaffold(
      appBar: const MyAppBar(
        title: Text(
          'Cart details',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        showBackArrow: true,
        backArrowColor: Colors.white,
      ),
      body:
          cart.products.isNotEmpty ? _getCartProducts(ref) : _cartEmptyState(),
      bottomNavigationBar: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: Text(
                'Total: \$${ref.watch(cartProvider).totalAmount().toStringAsFixed(2)}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _cartEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_shopping_cart, size: 80, color: Colors.black26),
          Text('Your cart is empty'),
        ],
      ),
    );
  }

  ListView _getCartProducts(WidgetRef ref) {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: ref.watch(cartProvider).cart.products.length,
        separatorBuilder: (context, index) => const Gap(10),
        itemBuilder: (context, index) {
          Product product = ref.watch(cartProvider).cart.products[index];

          return SizedBox(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product.image,
                    width: 80,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            product.title,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (product.quantity > 1) {
                                    ref
                                        .read(cartProvider.notifier)
                                        .decrementQuantity(product.id);
                                  } else {
                                    _showDeleteConfirmationModal(
                                        context, ref, product);
                                  }
                                },
                                icon: const Icon(Icons.remove),
                                iconSize: 16,
                              ),
                              Text(
                                '${product.quantity}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              IconButton(
                                onPressed: () {
                                  ref
                                      .read(cartProvider.notifier)
                                      .incrementQuantity(product.id);
                                },
                                icon: const Icon(Icons.add),
                                iconSize: 16,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

_showDeleteConfirmationModal(context, ref, product) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Confirmation'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              ref.read(cartProvider.notifier).decrementQuantity(product.id);
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
