import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/connection.dart';
import 'package:frontend/home_screen.dart';
import 'package:frontend/profile.dart';
import 'package:frontend/userform.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key, required this.username});

  final String username;

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  ApiService apiService = ApiService();
  List<dynamic> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getWishlist(widget.username);
    // Add items to current user's wishlist
    //exampleItems.forEach(currentUser.addToWishlist);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 175, 202, 250),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Center(child: Text('Wishlist')),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle), // Profile icon
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => UserForm()),
                (route) => false,
              );
            },
          ),
        ]
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: GestureDetector(
            child: Icon(Icons.home),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(username: widget.username,)),
                (route) => false,
              );
            }
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: GestureDetector(
            child: Icon(Icons.favorite),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => WishlistScreen(username: widget.username,)), 
                (route) => false,
              );
            },
          ),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: GestureDetector(
            child: Icon(Icons.person),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => Profile(usernameP: widget.username,)), 
                (route) => false,
              );
            },
          ),
          label: 'Profile',
        ),
      ],
      backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.image), // Placeholder for image
              title: Text(items[index]['name']),
              subtitle: Text('${items[index]['description']} - \$${items[index]['price']}'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => {} //need a remove function here
              ),
            ),
          );
        },
      ),
    );
  }

    void getWishlist(String user) async { 
    setState(() {
      isLoading = true; // ✅ Show loading spinner
    });

    try { 
      await Future.delayed(Duration(seconds: 2)); // Simulate API delay
      List<dynamic> fetchedItems = await apiService.getWishlist(widget.username); 
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
} 
// could not push code


