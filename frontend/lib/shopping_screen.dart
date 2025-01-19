import 'package:frontend/product_item.dart';
import 'package:flutter/cupertino.dart';

class ShoppingScreen extends StatefulWidget {
   ShoppingScreen({
    super.key,
    required this.category,
    });

  final String category;
  final Map<String,ProductItem> store = {};

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}