import 'package:flutter/material.dart';
import 'package:frontend/profile.dart';

class ItemListing extends StatefulWidget {
  const ItemListing({super.key});

  @override
  State<ItemListing> createState() => _ItemListingState();
}

class _ItemListingState extends State<ItemListing> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  String errorMessage = '';
  String itemName = 'default';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 175, 202, 250),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Text('Item Listing'),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: GestureDetector(
            child: Icon(Icons.person),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => Profile()), 
                (route) => false,
              );
            },
          ),
          label: 'Profile',
        ),
      ],
      backgroundColor: Colors.blueAccent,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Item name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.book),
              ),
              validator: (value) {
                if(value==null ||value.isEmpty) {
                  return 'Incomplete';
                }
                return null;
              }
            ),
            ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    setState(() {
                      errorMessage = '';
                      itemName = nameController.text;
                    });
                  }
                  else{
                    setState(() {
                      errorMessage = 'Please Correct the errors';
                    });
                  }
                }, 
                child: const Text('Go'),
              ),
          ],
        ),
      ),
    );
  }
}