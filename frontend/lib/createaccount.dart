import 'package:flutter/material.dart';
import 'package:frontend/connection.dart';
import 'package:frontend/userform.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final _formKey = GlobalKey<FormState>();
  String ? _nameVal;
  String ? _emailVal;
  String ? _passwordVal;
  final ApiService apiService= ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 200, bottom: 200),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value==null || value.isEmpty) {
                      return 'Please Enter a Username';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _nameVal = value;
                  },
      
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value==null || value.isEmpty) {
                      return 'Please Enter Your Email';
                    }
                    if(!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please Enter a Valid Email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _emailVal = value;
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
                  onSaved: (value) {
                    _passwordVal = value;
                  },
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  child: const Text('Create Account'),
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _submitUser(context);
                      Navigator.pushAndRemoveUntil(
                        context, 
                        MaterialPageRoute(builder: (context) => UserForm()), 
                        (route) => false,
                      );
                    }
                  }, 
                ),          
        
              ],
            ),
          ),
        ),
      ),
    );
  }

    void _submitUser(BuildContext context) async {
    String valueName = _nameVal ?? '';
    try {
      final result = await apiService.addUser(
        name: valueName, 
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