import 'package:get/get.dart';
class SplashScreenController extends GetxController {

  @override
  void onInit() async {
    super.onInit();
    Future.delayed(Duration(seconds: 5), () {
      print("After 5 seconds");
      Get.offNamedUntil('/', (route) => false);
    });
  }
}