import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/coloured_container.dart';
import '../components/expandable_tile.dart';
import '../components/filter_card.dart';
import '../components/icon_column.dart';
import '../controllers/event_controller.dart';

class TransparentAppBarScreen extends StatelessWidget {
  final EventController eventController = Get.find<EventController>();

  TransparentAppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => eventController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 60),
              _buildExpandableTiles(),
              const SizedBox(height: 32),
              _buildEventGrid(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) {
            Get.offAllNamed('/home'); // Use offAllNamed to prevent stack buildup
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
    );
  }

  Widget _buildHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          'assets/images/marathon.jpg',
          height: 300,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          height: 80,
          color: Colors.grey[900]!.withAlpha(190),
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/images/mge_logo.png',
              height: 30,
            ),
          ),
        ),
        Positioned(
          bottom: -45,
          left: 16,
          right: 16,
          child: Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[900]!.withAlpha(180),
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "SALALAH HALF MARATHON",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "19TH OCT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/salalah_logo.png',
                    width: 150,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExpandableTiles() {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          ExpandableTile(
            initialTitle: 'RACE OVERVIEW',
            expandedTitle: 'About the race',
            titleColor: Colors.yellow,
            containerColor: Colors.grey[700]!,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Text(
                  '''Suitable for All Levels
                  A Unified Community Charitable Giving Personal Achievements''',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          ExpandableTile(
            initialTitle: 'RACE CONDITIONS',
            expandedTitle: 'RACE CONDITIONS',
            titleColor: Colors.lightBlueAccent,
            containerColor: Colors.grey[700]!,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        IconColumn(
                          assetPath: 'assets/images/SWIM.png',
                          label: 'SWIM:',
                          value: 'N/A',
                        ),
                        IconColumn(
                          assetPath: 'assets/images/bike_icon.png',
                          label: 'BIKE:',
                          value: 'N/A',
                        ),
                        IconColumn(
                          assetPath: 'assets/images/run_icon.png',
                          label: 'RUN:',
                          value: 'FLAT',
                        ),
                        IconColumn(
                          assetPath: 'assets/images/temp_icon.png',
                          label: 'AVG AIR TEMP:',
                          value: '88°F, 31°C',
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(width: 10),
                        IconColumn(
                          assetPath: 'assets/images/water_icon.png',
                          label: 'AVG WATER\nTEMP:',
                          value: 'N/A',
                          isMultilineValue: true,
                        ),
                        SizedBox(width: 15),
                        IconColumn(
                          assetPath: 'assets/images/distance_icon.png',
                          label: 'DISTANCE:',
                          value: '5K',
                        ),
                        SizedBox(width: 10),
                        IconColumn(
                          assetPath: 'assets/images/flight_icon.png',
                          label: 'AIRPORT:',
                          value: 'SAL',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          ExpandableTile(
            initialTitle: 'JOIN THE RACE',
            expandedTitle: 'REGISTRATION STATUS: OPEN',
            titleColor: Colors.orangeAccent,
            containerColor: Colors.grey[700]!,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ColoredContainer(
                      color: Colors.yellow,
                      icon: Icons.edit,
                      label: 'REGISTER',
                      onTap: () => eventController.navigateTo('/register'),
                    ),
                    ColoredContainer(
                      color: Colors.blue,
                      icon: Icons.map,
                      label: 'RACE MAP',
                      onTap: () => eventController.navigateTo('/map'),
                    ),
                    ColoredContainer(
                      color: Colors.orange,
                      icon: Icons.directions,
                      label: 'ATHLETES GUIDE',
                      onTap: () => eventController.navigateTo('/guide'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEventGrid() {
    final List<Map<String, dynamic>> eventFilters = [
      {
        'title': 'BY DATE',
        'imagePath': 'assets/images/calendar.jpg',
        'icon': Icons.calendar_today,
        'route': '/calendar',
      },
      {
        'title': 'BY LOCATION',
        'imagePath': 'assets/images/by_location.jpg',
        'icon': Icons.location_on,
        'route': '/location',
      },
      {
        'title': 'UPCOMING',
        'imagePath': 'assets/images/upcoming.jpg',
        'icon': Icons.event,
        'route': '/filter/2',
      },
      {
        'title': 'COMPLETED',
        'imagePath': 'assets/images/completed.jpg',
        'icon': Icons.flag,
        'route': '/filter/3',
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: eventFilters.length,
        itemBuilder: (context, index) {
          final filter = eventFilters[index];
          return FilterCard(
            title: filter['title'],
            imagePath: filter['imagePath'],
            icon: filter['icon'],
            onTap: () => eventController.navigateTo(filter['route']),
          );
        },
      ),
    );
  }
}