import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Simulate loading completion
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
    });
  }
}