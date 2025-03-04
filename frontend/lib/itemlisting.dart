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
  String? _inputValueD;
  File ? _selectedImage;
  String? imageURL;
  //bool _showWidget = false;
  //Map<String,dynamic> urlMap = {};

  //need to create an id variable that we can set equal to the id but not display in each section that can be passed in (this is important for checkout)

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
                MaterialPageRoute(builder: (context) => Profile(usernameP: widget.usernameH,)), 
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
            onPressed: () async {
              _pickImageFromGallery();
              // if (_selectedImage == null) {
              //   print("No image selected");
              // }else{
              //   getUrl();
              // }
              //imageURL = urlMap['image_url'];
              //_showWidget = true;
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
                    },
                    onSaved: (value) {
                      _inputValueD = value;
                    },
                  ),
                  TextFormField(
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
                  _selectedImage != null ?  Image.file(_selectedImage!) : const Text('Please select an Image'),
                  //if (_showWidget == true) 
                    //Text(imageURL!),
                  
                  ElevatedButton(
                      onPressed: () async {
                        if(_formKey.currentState!.validate()) {
                          //need to send all data to backend in an item object
                          //if (_selectedImage != null) {
                          //   await getUrl(); // ✅ Wait for image upload before submitting
                          // }
                          // if (imageURL == null || imageURL == 'error') {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(content: Text('Error: Image upload failed.'))
                          // );
                          // return;
                          // }
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

Future<void> _pickImageFromGallery() async {
  final returnedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    //imageQuality: 85, // Reduce file size
    //preferredCameraDevice: CameraDevice.rear,
  );

  if (returnedImage == null) {
    print("No image selected");
    return;
  }

  // Convert HEIF to JPG
  // final File convertedImage = File('${returnedImage.path}.jpg');
  //await returnedImage.saveTo(convertedImage.path);

  setState(() {
    _selectedImage = returnedImage as File?;
  });

  //await getUrl(); // ✅ Ensure upload happens after conversion

  // if (imageURL == null) {
  //   print("Image upload failed.");
  // } else {
  //   print("Image successfully uploaded: $imageURL");
  // }
}

  void _submitItem(BuildContext context) async {
    double valueNum = _inputValue ?? 0.0;
    String valueCat = _inputValueC ?? '';
    String valueName = _inputValueN ?? '';
    String valueDescription = _inputValueD ?? '';
    //String url = imageURL ?? 'error';
    try {
      final result = await apiService.addItem(
        name: valueName, 
        price: valueNum,
        category: valueCat,
        description: valueDescription,
        sellerName: widget.usernameH,
       // imageUrl: '',
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

// Future<void> getUrl() async { 
//   if (_selectedImage == null) return;

//   try { 
//     Map<String, dynamic> fetchedUrl = await apiService.uploadImageToBackend(_selectedImage!) ?? {};
//     setState(() { 
//       urlMap = fetchedUrl;
//       imageURL = urlMap['image_url']; // Ensure UI updates
//       _showWidget = true; // Display the widget
//     }); 
//   } catch (e) { 
//     print("Error getting URL: $e"); 
//   } 
// }
}
    
