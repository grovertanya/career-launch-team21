import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
 
  final List<AssetImage> imageList = [
    AssetImage('assets/images/fridge.webp'),
    AssetImage('assets/images/pillow.jpg'),
    AssetImage('assets/images/table.webp'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
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
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      backgroundColor: Colors.red,
      )
      ,
      body: Container(
        height: 1000,
        padding: const EdgeInsets.only(top: 50),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                Padding(padding: const EdgeInsets.all(16)),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 75,
                              height: 75,
                              child: Image.asset(
                                'assets/images/clothingIcon.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(left: 16)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(padding: const EdgeInsets.only(bottom: 50),),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 75,
                            height: 75,
                            child: Image.asset(
                              'assets/images/appliances.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(left: 16)),
                        Text(
                          'Applinces',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              width: 75,
                              height: 75,
                              child: Image.asset(
                                'assets/images/dormIcon.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(padding: const EdgeInsets.only(left: 16)),
                          Text(
                            'Dorm \nEssentials',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(padding: const EdgeInsets.only(bottom: 20),),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 75,
                            height: 75,
                            child: Image.asset(
                              'assets/images/ticketIcon.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.only(left: 16)),
                        Text(
                          'Tickets',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                'Newly Added',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: false,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8,
                ),
                items: imageList.map((ImageProvider) {
                  return Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: ImageProvider,
                        fit: BoxFit.cover,
                      )
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}