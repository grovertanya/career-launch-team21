import 'package:flutter/material.dart';
import 'package:frontend/connection.dart';

class ItemsView extends StatefulWidget {
  const ItemsView({required this.category, super.key});

  final String category;

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  
  final ApiService apiService = ApiService();
  List<dynamic> items = [];

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

  void searchByCategory(String category) async { 
    try { 
      List<dynamic> fetchedItems = await apiService.fetchItems(category); 
      setState(() { 
        items = fetchedItems; 
      }); 
    } catch (e) { 
        print("Error searching by category: $e"); 
    } 
  }
}