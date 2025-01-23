import 'package:flutter/material.dart';
import 'package:frontend/home_screen.dart';

class CheckoutSuccess extends StatefulWidget {
  const CheckoutSuccess({super.key, required this.usernameCS, required this.sellerNameCS});

  final String usernameCS;
  final String sellerNameCS;

  @override
  State<CheckoutSuccess> createState() => _CheckoutSuccessState();

}

class _CheckoutSuccessState extends State<CheckoutSuccess> {

  bool _showWidget = false;

  final _formKey = GlobalKey<FormState>();

  double ? rating;

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
                setState(() {
                  _showWidget = true;
                });
              }, 
              child: Text('Rate seller'),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
            ),
            if(_showWidget)
              Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Rating',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter a rating';
                        }
                        null;
                      },
                      onSaved: (value) {
                        String valueRat = value ?? '';
                        rating = double.tryParse(valueRat);
                      }
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          //rate a user function
                        }
                      }, 
                      child: const Text('Submit rating'),
                    ),
                  ]
                ),
              ),
            Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: (){
                Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => HomeScreen(username: widget.usernameCS,)), 
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