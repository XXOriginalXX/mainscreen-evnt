import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../controllers/home_controller.dart';
import '../models/event.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();
  late VideoPlayerController videoController;

  final List<Event> events = [
    Event(
      title: 'Salalah Half Marathon',
      date: '19th Oct 2024',
      imageUrl: 'assets/images/marathon.jpg',
    ),
    Event(
      title: 'SheRuns',
      date: '25th Oct 2024',
      imageUrl: 'assets/images/sheruns.jpg',
    ),
    Event(
      title: 'IRONMAN 70.3 SALALAH',
      date: '19th Oct 2024',
      imageUrl: 'assets/images/ironman.jpg',
    ),
  ];

  final List<Map<String, dynamic>> findEventOptions = [
    {
      'title': 'BY DATE',
      'icon': Icons.calendar_today,
      'color': Colors.amber,
      'imageUrl': 'assets/images/by_date.jpg',
    },
    {
      'title': 'BY LOCATION',
      'icon': Icons.location_on,
      'color': Colors.blue,
      'imageUrl': 'assets/images/by_location.jpg',
    },
    {
      'title': 'UPCOMING',
      'icon': Icons.event,
      'color': Colors.orange,
      'imageUrl': 'assets/images/upcoming.jpg',
    },
    {
      'title': 'COMPLETED EVENTS',
      'icon': Icons.flag,
      'color': Colors.green,
      'imageUrl': 'assets/images/completed.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.asset(
      'assets/videos/main_video.mp4',
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
      ),
    );
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      await videoController.initialize();
      videoController.setLooping(true);
      videoController.play();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
    }
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  Future<bool> _checkAssetExists(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (e) {
      print('Asset not found: $assetPath');
      return false;
    }
  }

  // Update the _buildHeaderSection() method in HomeScreen
  Widget _buildHeaderSection() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return videoController.value.isInitialized
                ? Stack(
              children: [
                VideoPlayer(videoController),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      setState(() {
                        if (videoController.value.isPlaying) {
                          videoController.pause();
                        } else {
                          videoController.play();
                        }
                      });
                    },
                    backgroundColor: Colors.white.withOpacity(0.7),
                    child: Icon(
                      videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            )
                : Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          }),
        ),
        Positioned(
          top: 40,
          left: 16,
          child: Image.asset(
            'assets/images/mge_logo.png',
            height: 30,
            errorBuilder: (context, error, stackTrace) {
              debugPrint('Error loading logo: $error');
              return const SizedBox(height: 30);
            },
          ),
        ),
      ],
    );
  }
  Widget _buildEventsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return GestureDetector(
          onTap: () {
            if (event.title == 'Salalah Half Marathon') {
              Get.toNamed('/event');
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300],
                image: DecorationImage(
                  image: AssetImage(event.imageUrl),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    print('Error loading image: $exception');
                  },
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          event.date,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFindEventGrid() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: findEventOptions.length,
        itemBuilder: (context, index) {
          final option = findEventOptions[index];
          return InkWell(
            onTap: () {
              switch (option['title']) {
                case 'BY DATE':
                  Get.toNamed('/calendar');
                  break;
                case 'BY LOCATION':
                  Get.toNamed('/location');
                  break;
                default:
                  Get.snackbar(
                    'Selected Option',
                    'You selected ${option['title']}',
                    snackPosition: SnackPosition.BOTTOM,
                  );
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(option['imageUrl']),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      option['icon'],
                      size: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      option['title'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'UPCOMING FEATURED EVENTS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildEventsList(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'FIND YOUR EVENT',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildFindEventGrid(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
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
}