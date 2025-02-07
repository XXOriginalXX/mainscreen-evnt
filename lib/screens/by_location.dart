import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package

import '../components/expandable_tile.dart';

class ByLocation extends StatelessWidget {
  const ByLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/lctn.png',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 70,
                    color: Colors.grey[900]!.withAlpha(190),
                    padding: EdgeInsets.only(top: 20, left: 16),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        height: 20,
                        'assets/images/mge_logo.png',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 110,
                          width: 380,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[700]!.withAlpha(190),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 30,
                          child: Text(
                            'EVENTS BY LOCATION',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          child: Image.asset(
                            'assets/images/location.png',
                            height: 110,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpandableTile(
                      initialTitle: 'MUSCAT',
                      expandedTitle: 'MUSCAT',
                      titleColor: Colors.yellow,
                      containerColor: Colors.grey[900]!.withAlpha(190),
                      iconColor: Colors.white,
                      children: [],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpandableTile(
                      initialTitle: 'SALALAH',
                      expandedTitle: 'SALALAH',
                      titleColor: Colors.yellow,
                      containerColor: Colors.grey[900]!.withAlpha(190),
                      iconColor: Colors.white,
                      children: [],
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            onTap: (index) {
              if (index == 0) {
                Get.offAllNamed('/home'); // Use offAllNamed to clear the stack
              } else if (index == 1) {
                Get.toNamed('/login');
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ));
  }
}
