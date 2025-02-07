import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _isNavigating = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    initializeVideo();
  }

  Future<void> initializeVideo() async {
    try {
      _controller = VideoPlayerController.asset(
        "assets/videos/splash.mp4",
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );

      await _controller.initialize();

      if (!mounted) return;

      setState(() {});

      _controller.setPlaybackSpeed(0.8);
      _controller.play();

      _controller.setLooping(false);
      _controller.addListener(checkVideoCompletion);

    } catch (e) {
      debugPrint("Error initializing video: $e");
      setState(() {
        _hasError = true;
      });
      await Future.delayed(const Duration(milliseconds: 1500));
      navigateToHome();
    }
  }

  void checkVideoCompletion() {
    if (_controller.value.position >= _controller.value.duration) {
      navigateToHome();
    }
  }

  void navigateToHome() {
    if (!_isNavigating && mounted) {
      _isNavigating = true;
      Get.offNamed('/home');
    }
  }

  @override
  void dispose() {
    if (!_hasError) {
      _controller.removeListener(checkVideoCompletion);
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Loading...',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: !_hasError && _controller.value.isInitialized
            ? FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: VideoPlayer(_controller),
          ),
        )
            : const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}