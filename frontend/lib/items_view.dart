import 'package:flutter/material.dart';
import 'package:frontend/connection.dart';
import 'package:frontend/item_details.dart';

class ItemsView extends StatefulWidget {
  const ItemsView({required this.category, super.key, required this.usernameIV});

  final String category;
  final String usernameIV;

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  
  final ApiService apiService = ApiService();
  List<dynamic> items = [];

  @override
  void initState() {
    super.initState();
     searchByCategory(widget.category);
    // Trigger API call only once.
  }

  @override
  Widget build(BuildContext context) {
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
                    child: GestureDetector(
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                items[index]['imageurl'],
                                width: 10,
                                height: 10,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(16),
                                title: Text(items[index]['name']), titleTextStyle: 
                                  TextStyle(
                                    fontSize: 18, 
                                    fontWeight: FontWeight.bold, 
                                    color: const Color.fromARGB(255, 25, 25, 26),
                                  ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8 ),
                                  child: Text(
                                    "\$${items[index]['price']} - ${items[index]['category']}",
                                    style: TextStyle(
                                      fontSize: 14, 
                                      color: Colors.grey),
                                    ),
                                  ),
                                                        ),
                            ),
                          ]
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemDetails(
                          name: items[index]['name'], 
                          description: 'sample for now', 
                          price: items[index]['price'], 
                          itemUsername: items[index]['seller'], 
                          imageUrl: items[index]['imageurl'],
                          usernameID: widget.usernameIV, 
                          id: items[index]['id'],
                        )));
                      },
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