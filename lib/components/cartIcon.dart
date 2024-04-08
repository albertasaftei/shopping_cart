import 'package:flutter/material.dart';
import 'package:shopping_cart/models/cart_model.dart';
import 'package:shopping_cart/pages/cart_details.dart';
import 'package:badges/badges.dart' as badges;

Padding shoppingCartIcon(context, ref) {
  return Padding(
    padding: const EdgeInsets.only(right: 15),
    child: badges.Badge(
      position: badges.BadgePosition.custom(
        top: -4,
        end: -4,
      ),
      badgeContent: Text(
        ref.watch(cartProvider).totalQuantityProducts().toString(),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      badgeAnimation: const badges.BadgeAnimation.rotation(),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: Colors.black54,
      ),
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartDetails()),
          );
        },
        icon: const Icon(
          Icons.shopping_cart_outlined,
          color: Colors.white,
        ),
      ),
    ),
  );
}
