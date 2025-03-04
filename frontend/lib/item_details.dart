import 'package:flutter/material.dart';
import 'package:frontend/checkout.dart';
import 'package:frontend/connection.dart';

//the item info will be passed into this from the items_view page (no need for backend)
//we need a backend function in this file for retreiving user data based on the username under the item

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key, required this.name, required this.description, required this.price, required this.itemUsername, required this.usernameID, required this.id});

  final String name;
  final String description;
  final double price;
  final String itemUsername;
  //final double userRating;
 // final String imageUrl;
  final String usernameID;
  final String id;
  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {

  List<dynamic> user = [];
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Center(child: Text('Product Details')),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Image.asset('assets/images/placeholder.webp'), //replace with imageUrl once its integrated through backend 
                ),
              ),
              //wrap in padding
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,0),
                child: Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,0),
                child: Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 119, 119, 119),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,0),
                child: Text(
                  '\$${widget.price}',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,10,0),
                child: Text(
                  'Sold by: ${widget.itemUsername}, ${user.isNotEmpty ? user[0]['rating'] : "No rating available"}',
                  style: TextStyle(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 119, 119, 119),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,0,10),
                child: SizedBox(
                  child: ElevatedButton(
                    onPressed: (){},
                    child: Text(
                      'Contact User',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 33, 66, 123),
                      )
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10,10,0,10),
                child: SizedBox(
                  child: ElevatedButton(
                    onPressed: (){
                      addToWishlist(context);
                    },
                    child: Text(
                      'Add to Wishlist',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 33, 66, 123),
                      )
                    ),
                  )
                ),
              ),
              Center(
                child: SizedBox(
                  height: 85,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: (){
                      //need to pass in some sort of id
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Checkout(
                            usernameC: widget.usernameID, 
                            sellerName: widget.itemUsername, 
                            itemID: widget.id, 
                            itemName: widget.name, 
                            description: widget.description, 
                            price: widget.price,
                            )
                        ),
                      );
                    }, 
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 30,
                        color: const Color.fromARGB(255, 33, 66, 123),
                        fontWeight: FontWeight.bold,
                      )
                    )
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void getUserInfo(String username) async { 
    try { 
      List<dynamic> fetchedUser = await apiService.fetchUser(username); 
      setState(() { 
        user = fetchedUser; 
      }); 
    } catch (e) { 
        print("Error searching by category: $e"); 
    } 
  }

    void addToWishlist(BuildContext context) async {
    try {
      final result = await apiService.addToWishlist(
        user: widget.usernameID,
        id: widget.id,
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