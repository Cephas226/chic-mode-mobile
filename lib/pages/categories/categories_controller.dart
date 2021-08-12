import 'package:get/get.dart';
import 'package:getx_app/pages/home/home_controller.dart';

class CategoriesController extends GetxController {
  final HomeController _prodController = Get.put(HomeController());
  @override
  void onInit() async{
    super.onInit();
  }
  @override
  void dispose() {
    _prodController.bannerAd.dispose();
    _prodController.interstitialAd.dispose();
    super.dispose();
  }
}
