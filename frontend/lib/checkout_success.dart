import 'package:flutter/material.dart';
import 'package:frontend/home_screen.dart';

class CheckoutSuccess extends StatelessWidget {
  const CheckoutSuccess({super.key, required this.usernameCS, required this.sellerNameCS});

  final String usernameCS;
  final String sellerNameCS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Center(child: Text('Checkoout')),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 173, 255, 175),
              child: SizedBox(
                width: 100,
                height: 20,
                child: Text(
                  'Success',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 34, 67, 35),
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
            ),
             ElevatedButton(
              onPressed: (){
                //this is where we would pass the function to rate user
              }, 
              child: Text('Rate seller'),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => HomeScreen(username: usernameCS,)), 
                (route) => false,
              );
              }, 
              child: Text('Finish'),
            )
          ],
        )
      ),
    );
  }
}