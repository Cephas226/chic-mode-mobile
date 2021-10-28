import 'package:get/get.dart';
import 'package:getx_app/pages/dashboard/dashboard_page.dart';
import 'package:getx_app/pages/home/home_controller.dart';
import 'package:getx_app/themes/color_theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
 

class CategoriesController extends GetxController { 
   final HomeController _prodController = Get.put(HomeController());
 BannerAd? _bannerAd;
  InterstitialAd? interstitialAd;
    int _numInterstitialLoadAttempts = 0;
     int maxFailedLoadAttempts = 3;


      void onInit() {
    _createInterstitialAd();
    super.onInit();
  }
   showInterstitialAd() {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
         Get.off(() => DashboardPage());
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }
   @override
  void dispose() {
    super.dispose();
    interstitialAd?.dispose();
    _bannerAd?.dispose();
  }
      _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: interstitielUnitID,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }
}
