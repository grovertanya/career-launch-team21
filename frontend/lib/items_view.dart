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
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Expanded( 
          child: items.isEmpty
          
            ? Center(child: Text("No items found")) 
            : ListView.builder( 
                itemCount: items.length, 
                itemBuilder: (context, index) { 
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(items[index]['name']), titleTextStyle: TextStyle(
                          fontSize: 18, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.blueAccent,),
                          subtitle: Padding(padding: const EdgeInsets.only(top: 8 ),
                          child: Text("\$${items[index]['price']} - ${items[index]['category']}",
                          style: TextStyle(fontSize: 14, color: Colors.grey),),),
                      ),
                    ),
                  );
                
                }, 
                
              ),
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