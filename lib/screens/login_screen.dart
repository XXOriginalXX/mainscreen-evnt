import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController controller = Get.find<AuthController>();
  late VideoPlayerController videoController;
  bool isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      videoController = VideoPlayerController.asset(
        'assets/videos/main_video.mp4',
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
        ),
      );

      await videoController.initialize();
      await videoController.setLooping(true);
      await videoController.play();

      if (mounted) {
        setState(() {
          isVideoInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Error initializing video: $e');
      if (mounted) {
        setState(() {
          isVideoInitialized = false;
        });
      }
    }
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  Future<void> _launchRegisterURL() async {
    final Uri url = Uri.parse('https://www.mege.om/register');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Video player section
            AspectRatio(
              aspectRatio: 16 / 9,
              child: isVideoInitialized
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      labelText: 'USERNAME / EMAIL',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'PASSWORD',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => controller.login(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      'LOG IN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: _launchRegisterURL,
                    child: const Text(
                      'REGISTER',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Get.offNamed('/home');
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