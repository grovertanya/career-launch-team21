import 'package:flutter/material.dart';
import 'package:frontend/connection.dart';
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 200,
                height: 100,
                child: Container(
                  color: const Color.fromARGB(255, 173, 255, 175),
                  child: Center(
                    child: Text(
                      'Success',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 34, 67, 35),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )
                    ),
                  ),
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
            if(_showWidget == true)
              Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
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
                          _rateUser(context);
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

  void _rateUser(BuildContext context) async {
    double ratingVal = rating ?? -1;
    if(rating!= -1){
      try {
        final result = await apiService.rateUser(
          buyerUsername: widget.usernameCS, 
          sellerUsername: widget.sellerNameCS, 
          rating: ratingVal,
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
}