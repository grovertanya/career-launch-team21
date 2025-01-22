import 'package:flutter/material.dart';
import 'package:frontend/connection.dart';
import 'package:frontend/home_screen.dart';
import 'package:frontend/itemlisting.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.usernamePV, required this.dateJoined, required this.rating, required this.ratings});
  final String usernamePV;
  final String dateJoined;
  final double rating;
  final int ratings;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  ApiService apiService = ApiService();
  List<dynamic> user = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 175, 202, 250),
      appBar: AppBar(
        title: Text(
          'User Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: GestureDetector(
            child: Icon(Icons.home),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => HomeScreen(username: widget.usernamePV,)), 
                (route) => false,
              );
            },
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(20)),
          Icon(Icons.person,
          size: 200,),
          Padding(padding: EdgeInsets.all(20)),
          buildTextSections('      Name', user[0]['name']),
          buildTextSections('      Username', user[0]['username']),
          //buildTextSections('      Date Joined', widget.dateJoined),
          buildTextSections('      Rating', user[0]['rating']),
          //buildTextSections('      Ratings', user[0]['ratingCount']),
          Padding(padding: EdgeInsets.only(top: 40)),
          SizedBox(
            height: 85,
            width: 300,
            child: ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ItemListing(usernameH: widget.usernamePV,)));
              }, 
              child: Text(
                'List an Item',
                style: TextStyle(
                  fontSize: 30,
                  color: const Color.fromARGB(255, 33, 66, 123),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextSections(String section, var item) {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Text(
            '$section:   ', 
            style: TextStyle(
              fontSize: 30, 
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$item', 
            style: TextStyle(
              fontSize: 30, 
            ),
          ),
        ],
      ),
    );
  }

  void getUserInfo(String category) async { 
    try { 
      List<dynamic> fetchedUser = await apiService.fetchUser(widget.usernamePV); 
      setState(() { 
        user = fetchedUser; 
      }); 
    } catch (e) { 
        print("Error searching by category: $e"); 
    } 
  }
}