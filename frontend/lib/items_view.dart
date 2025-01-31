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
  bool isLoading = true;

  @override
  void initState() {
    super.initState(); 
    searchByCategory(widget.category); // ✅ Fetch items when screen loads
  }

  void searchByCategory(String category) async { 
    setState(() {
      isLoading = true; // ✅ Show loading spinner
    });

    try { 
      await Future.delayed(Duration(seconds: 2)); // Simulate API delay
      List<dynamic> fetchedItems = await apiService.fetchItems(category);
      
      setState(() { 
        items = fetchedItems;
        isLoading = false; // ✅ Hide loading spinner after data is ready
      });

      print("Fetched Items: $items"); // ✅ Debugging print

    } catch (e) { 
      print("Error searching by category: $e"); 
      setState(() {
        isLoading = false;
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category), backgroundColor: Colors.blueAccent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // ✅ Show loading indicator
            : items.isEmpty
                ? Center(child: Text("No items found")) // ✅ Prevent invalid index error
                : ListView.builder(
                    itemCount: items.length, 
                    itemBuilder: (context, index) { 
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.asset('assets/images/placeholder.webp'),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(16),
                                    title: Text(items[index]['name']), 
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        "\$${items[index]['price']} - ${items[index]['category']}",
                                        style: TextStyle(fontSize: 14, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            print("Navigating with item: ${items[index]}");
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ItemDetails(
                                name: items[index]['name'] ?? "Unknown Name", 
                                description: items[index]['description'] ?? "No description", 
                                price: (items[index]['price'] ?? 0).toDouble(), 
                                itemUsername: items[index]['seller'] ?? "Unknown Seller", 
                                usernameID: widget.usernameIV, 
                                id: items[index]['id'] ?? "0", 
                              ),
                            ));
                          },
                        ),
                      );
                    },
                ),
      ),
    );
  }



  // Widget displayImage(String url) {
  //   if (url.isEmpty) {
  //     return Image.asset(
  //       'assets/images/placeholder.webp',
  //         width: 10,
  //         height: 10,
  //         fit: BoxFit.cover,
  //     );
  //   }else{
  //     return Image.network(
  //       url,
  //       width: 10,
  //       height: 10,
  //       fit: BoxFit.cover,
  //     );
  //   }
  // }
}