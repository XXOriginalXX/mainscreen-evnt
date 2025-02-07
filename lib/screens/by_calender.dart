import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get package

import '../components/border_colored_container.dart';

class ByCalendarPage extends StatelessWidget {
  const ByCalendarPage({super.key});

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
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      Container(
                        height: 108,
                        width: 340,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[900]!.withAlpha(120),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Text(
                          'CALENDAR 2024/2025',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 8,
                        child: Image.asset(
                          'assets/images/calendar_logo.png',
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BorderColoredContainer(
                              month: 'JANUARY', bordercolor: Colors.yellow, hasEvent: true),
                          SizedBox(width: 8),
                          BorderColoredContainer(
                              month: 'FEBRUARY', bordercolor: Colors.blue, hasEvent: true),
                          SizedBox(width: 8),
                          BorderColoredContainer(
                              month: 'MARCH', bordercolor: Colors.orange, hasEvent: true),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BorderColoredContainer(month: 'APRIL', bordercolor: Colors.yellow),
                          SizedBox(width: 8),
                          BorderColoredContainer(month: 'MAY', bordercolor: Colors.blue),
                          SizedBox(width: 8),
                          BorderColoredContainer(month: 'JUNE', bordercolor: Colors.orange),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BorderColoredContainer(month: 'JULY', bordercolor: Colors.yellow),
                          SizedBox(width: 8),
                          BorderColoredContainer(
                              month: 'AUGUST', bordercolor: Colors.blue, hasEvent: true),
                          SizedBox(width: 8),
                          BorderColoredContainer(
                              month: 'SEPTEMBER', bordercolor: Colors.orange, hasEvent: true),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BorderColoredContainer(
                              month: 'OCTOBER', bordercolor: Colors.yellow, hasEvent: true),
                          SizedBox(width: 8),
                          BorderColoredContainer(
                              month: 'NOVEMBER', bordercolor: Colors.blue, hasEvent: true),
                          SizedBox(width: 8),
                          BorderColoredContainer(
                              month: 'DECEMBER', bordercolor: Colors.orange, hasEvent: true),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
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
      ),
    );
  }
}
