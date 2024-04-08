import 'package:flutter/material.dart';
import 'package:shopping_cart/pages/products_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_cart/utils/theme.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping cart',
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      home: const ShoppingCart(),
    );
  }
}
