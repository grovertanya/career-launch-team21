import 'package:flutter/material.dart';
import 'package:frontend/checkout_success.dart';
import 'package:frontend/connection.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key, required this.usernameC, required this.sellerName, required this.itemID});

  final String usernameC;
  final String sellerName;
  final String itemID;

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
        title: Center(child: Text('Checkoout')),
      ),
      body: Column(
        children: [
          Text('This is the checkout screen'),
          ElevatedButton(
            onPressed: (){
              _removeItem(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckoutSuccess(usernameCS: widget.usernameC, sellerNameCS: widget.sellerName,)));
            }, child: Text('Confirm purchase'))
        ],
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