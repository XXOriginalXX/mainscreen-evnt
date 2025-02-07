import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/event_controller.dart';
import 'screens/event_details.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/by_calender.dart';
import 'screens/by_location.dart';
import 'controllers/home_controller.dart';
import 'controllers/auth_controller.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Events App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(HomeController());
        Get.put(AuthController());
        Get.put(EventController());
      }),
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/event', page: () => TransparentAppBarScreen()),
        GetPage(name: '/calendar', page: () => const ByCalendarPage()),
        GetPage(name: '/location', page: () => const ByLocation()),
      ],
      initialRoute: '/',
    );
  }
}

