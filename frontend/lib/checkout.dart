import 'package:flutter/material.dart';
import 'package:frontend/checkout_success.dart';
import 'package:frontend/connection.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key, required this.usernameC, required this.sellerName, required this.itemID, required this.itemName, required this.description, required this.price});

  final String usernameC;
  final String sellerName;
  final String itemID;
  final String itemName;
  final String description;
  final double price;

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Center(child: Text('Checkout')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Centers horizontally
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
              child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(widget.itemName), titleTextStyle: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                color: Colors.blueAccent,
                ),
              subtitle: Padding(padding: const EdgeInsets.only(top: 8),
                child: Text(
                  widget.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey),),),
              ),
            ),
            SizedBox(height: 20,),
            Text(
              'Total: \$${widget.price}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                _removeItem(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckoutSuccess(usernameCS: widget.usernameC, sellerNameCS: widget.sellerName,)));
              }, child: Text('Confirm purchase'))
          ],
        ),
      )
    );
  }

  void _removeItem(BuildContext context) async {
    String idP = widget.itemID;
    String username = widget.usernameC;
    try {
      final result = await apiService.markItemAsSold(
        id: idP, 
        buyerUsername: username
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