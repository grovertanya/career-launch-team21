import 'package:flutter/material.dart';
import 'package:frontend/checkout_success.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key, required this.usernameC, required this.sellerName});

  final String usernameC;
  final String sellerName;

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
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
              //need to call a function that will remove this item from the database
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CheckoutSuccess(usernameCS: widget.usernameC, sellerNameCS: widget.sellerName,)));
            }, child: Text('Confirm purchase'))
        ],
      )
    );
  }
}