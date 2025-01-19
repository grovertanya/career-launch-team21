import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.username,
    });
 
  final String username;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 175, 202, 250),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: CupertinoSearchTextField(
          backgroundColor: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: GestureDetector(
            child: Icon(Icons.person),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: (context) => Profile()), 
                (route) => false,
              );
            },
          ),
          label: 'Profile',
        ),
      ],
      backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        height: 5000,
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          alignment: Alignment.center,
          child: 
            Column(
              children: [
                Row(
                  children: [
                    Padding(padding: const EdgeInsets.all(16)),
                    Column(
                      children: [
                        buildCategoryDisplay('Clothing', 'assets/images/clothingIcon.png'),
                        buildCategoryDisplay('Appliances', 'assets/images/appliances.png'),
                      ],
                    ),
                    Column(
                      children: [
                        buildCategoryDisplay('Dorm \nEssentials', 'assets/images/dormIcon.png'),
                        buildCategoryDisplay('Tickets', 'assets/images/ticketIcon.png')
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(padding: const EdgeInsets.all(16)),
                    Column(
                      children: [
                        buildCategoryDisplay('Academic \nSupplies', 'assets/images/school.png'),
                        buildCategoryDisplay('Electronics', 'assets/images/electronics.png'),
                      ],
                    ),
                    Column(
                      children: [
                        buildCategoryDisplay('Furniture', 'assets/images/furniture.png'),
                        buildCategoryDisplay('More', 'assets/images/more.png')
                      ],
                    ),
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }

  Widget buildCategoryDisplay(String category, String imageURL) {
    return Container(
      padding: const EdgeInsets.only(bottom: 100),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 75,
              height: 75,
              child: Image.asset(
                imageURL,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.only(left: 16)),
          Text(
            category,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}