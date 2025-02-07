import 'package:get/get.dart';

class EventController extends GetxController {
  var isLoading = false.obs;

  void toggleLoading() {
    isLoading.value = !isLoading.value;
  }

  void navigateTo(String route) {
    switch (route) {
      case '/calendar':
        Get.toNamed('/calendar');
        break;
      case '/location':
        Get.toNamed('/location');
        break;
      case '/filter/0': // BY DATE
        Get.toNamed('/calendar');
        break;
      case '/filter/1': // BY LOCATION
        Get.toNamed('/location');
        break;
      case '/filter/2': // UPCOMING
        Get.snackbar(
          'Upcoming Events',
          'Navigating to upcoming events...',
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
      case '/filter/3': // COMPLETED
        Get.snackbar(
          'Completed Events',
          'Navigating to completed events...',
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
      case '/register':
        Get.snackbar(
          'Registration',
          'Opening registration form...',
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
      case '/map':
        Get.snackbar(
          'Race Map',
          'Opening race map...',
          snackPosition: SnackPosition.BOTTOM,
        );
        break;
      default:
        Get.toNamed(route);
    }
  }
}