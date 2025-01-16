import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        Text(
                          'Clothing',
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
        ],
      ),
    );
  }
}