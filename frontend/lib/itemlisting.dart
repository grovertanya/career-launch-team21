import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/connection.dart';
import 'package:frontend/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ItemListing extends StatefulWidget {
  const ItemListing({required this.usernameH,super.key});
  
  final String usernameH;
  @override
  State<ItemListing> createState() => _ItemListingState();

}

class _ItemListingState extends State<ItemListing> {

  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  double? _inputValue;
  String? _inputValueC;
  String? _inputValueN;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryContrller = TextEditingController();
  //String itemName = 'default';
  //double itemPrice = 0.0;
  //String itemDescription = 'default';
  //String itemCategory = 'default';
  File _selectedImage = File('');

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
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _pickImageFromGallery();
            }, 
            child: const Text(
              'Pick Image from Gallery',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Expanded(
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
                    },
                    onSaved: (value) {
                      _inputValueN = value;
                    },
                  ),
                  TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                      labelText: 'Item price',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.money),
                    ),
                    validator: (value) {
                      if(value==null ||value.isEmpty) {
                        return 'Incomplete';
                      }
                      if(double.tryParse(value) == null) {
                        _inputValue = 0;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _inputValue = double.tryParse(value!);
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Item description',
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
                  TextFormField(
                    controller: categoryContrller,
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.book),
                    ),
                    validator: (value) {
                      if(value==null ||value.isEmpty) {
                        return 'Incomplete';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _inputValueC = value;
                    },
                  ),
                  SizedBox(height: 20,),
                  Image.file(_selectedImage),
                  ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          //need to send all data to backend in an item object
                          _formKey.currentState!.save();
                          _submitItem(context);
                        }
                      }, 
                      child: const Text('Go'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
  }

  void _submitItem(BuildContext context) async {
    double valueNum = _inputValue ?? 0.0;
    String valueCat = _inputValueC ?? '';
    String valueName = _inputValueN ?? '';
    try {
      final result = await apiService.addItem(
        name: valueName, 
        price: valueNum,
        category: valueCat,
        sellerName: 'Alice',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Success: ${result["message"]}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
    
