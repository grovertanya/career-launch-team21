import 'package:flutter/material.dart';

const List<String> categories = [
  "Academic Supplies", "Appliances", "Clothing", "Electronics",
  "Furniture", "Dorm Essentials", "Tickets", "Other"
];

class User {
  final String name;
  List<Item> wishlist = [];
  User({required this.name}); // class to manage user details and wishlist

  void addToWishlist(Item item) => wishlist.add(item);
}

// Item class to manage item details
class Item {
  final String name, description, category;
  final double price;
  bool sold = false;
  final User seller;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.seller,
  }) {
   
    }
  }

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final User currentUser = User(name: 'John Doe');
  final List<Item> exampleItems = [
    Item(
      name: 'Laptop',
      description: 'A powerful laptop for coding and gaming.',
      price: 1000.0,
      category: 'Electronics',
      seller: User(name: 'Alice'),
    ),
    Item(
      name: 'Smartphone',
      description: 'A sleek smartphone with a great camera.',
      price: 800.0,
      category: 'Electronics',
      seller: User(name: 'Bob'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Add items to current user's wishlist
    exampleItems.forEach(currentUser.addToWishlist);
  }

  void removeItem(int index) {
    setState(() => currentUser.wishlist.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${currentUser.name}\'s Wishlist')),
      body: ListView.builder(
        itemCount: currentUser.wishlist.length,
        itemBuilder: (context, index) {
          final item = currentUser.wishlist[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.image), // Placeholder for image
              title: Text(item.name),
              subtitle: Text('${item.description} - \$${item.price}'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => removeItem(index),
              ),
            ),
          );
        },
      ),
    );
  }
} 
// could not push code


