import 'package:frontend/createaccount.dart';
import 'package:frontend/home_screen.dart';
import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  String errorMessage = '';
  String name = 'default';

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value==null || value.isEmpty) {
                      return 'Please Enter Your Username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value==null || value.isEmpty) {
                      return 'Please Enter Your Password';
                    }
                    if(value.length < 6) {
                      return 'Please Enter a Valid Password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      setState(() {
                        errorMessage = '';
                        name = nameController.text;
                      });
                      Navigator.pushAndRemoveUntil(
                        context, 
                        MaterialPageRoute(builder: (context) => HomeScreen()), 
                        (route) => false,
                      );
                    }
                    else{
                      setState(() {
                        errorMessage = 'Please Correct the errors';
                      });
                    }
                  }, 
                  child: const Text('Go'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => CreateAccount()),
                      (route) => false,
                    );
                  },
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color.fromARGB(255, 14, 30, 56),
                    )
                  ),
                )           
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}