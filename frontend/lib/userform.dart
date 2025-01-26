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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
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
                  onSaved: (value){
                    name = value ?? '';
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
                      _formKey.currentState!.save();
                      Navigator.pushAndRemoveUntil(
                        context, 
                        MaterialPageRoute(builder: (context) => HomeScreen(username: name,)), 
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