import 'package:flutter/material.dart';

class ItemsView extends StatefulWidget {
  const ItemsView({required this.category, super.key});

  final String category;

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Column(
        
      ),
    );
  }
}