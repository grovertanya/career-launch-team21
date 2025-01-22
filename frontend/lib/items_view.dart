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
    searchByCategory(widget.category);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Expanded( 
        child: items.isEmpty
          ? Center(child: Text("No items found")) 
          : ListView.builder( 
              itemCount: items.length, 
              itemBuilder: (context, index) { 
                return ListTile( 
                  title: Text(items[index]['name']), 
                  //subtitle: Text("\$${items[index]['price']} - ${items[index]['category']}"), 
                ); 
              }, 
            ),
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