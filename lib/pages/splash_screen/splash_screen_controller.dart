import 'package:get/get.dart';
import 'package:getx_app/pages/home/home_controller.dart';
class SplashScreenController extends GetxController {
  final HomeController _prodController = Get.put(HomeController());
  @override
  void onInit() async {
    super.onInit();
    Future.delayed(Duration(seconds: 5), () {
      print("After 5 seconds");
      Get.offNamedUntil('/', (route) => false);
    });
  }
}
