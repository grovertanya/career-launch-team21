import 'package:flutter/material.dart';

class WishlistItem {
  final String title;
  final String description;
  final String imageUrl;

  WishlistItem({required this.title, required this.description, required this.imageUrl});
}
class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  // ex list of wishlist items
  List<WishlistItem> wishlist = [
    WishlistItem(
      title: 'New Laptop',
      description: 'A powerful laptop for coding and gaming.',
      imageUrl: 'https://via.placeholder.com/150',
    ),
    WishlistItem(
      title: 'Smartphone',
      description: 'A sleek smartphone with a great camera.',
      imageUrl: 'https://via.placeholder.com/150',
    ),
  ];

  // Function to remove an item from the wishlist
  void removeItem(int index) {
    setState(() {
      wishlist.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          final item = wishlist[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(item.imageUrl),
              title: Text(item.title),
              subtitle: Text(item.description),
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


