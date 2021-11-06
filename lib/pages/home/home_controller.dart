import 'dart:convert';

//import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_app/model/product_model.dart';
import 'package:getx_app/pages/photos/photos_provider.dart';
import 'package:getx_app/themes/color_theme.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  String titlex = 'Accueil';
  RxList<Product> dataProduct = <Product>[].obs;
  RxList<Product> dataProductChip = <Product>[].obs;
  String productBoxName = 'product';
  var _selectedChip = 0.obs;
  get selectedChip => this._selectedChip.value;
  set selectedChip(index) => this._selectedChip.value = index;
  final box = GetStorage();

  late TabController controller;
  bool isFrench = false;
  final List<MyTabs> _tabs = [
    new MyTabs(title: "Accueil"),
    new MyTabs(title: "Noter"),
    new MyTabs(title: "Video"),
  ];
  late Rx<MyTabs> myHandler;
  bool checkConfiguration() => true;
  var monContext;
  InterstitialAd? interstitialAd;
  RxString messageTitle = "Empty".obs;
  RxString notificationAlert = "alert".obs;
  int numInterstitialLoadAttempts = 0;
   int maxFailedLoadAttempts = 3;
  BannerAd? bannerAd;
  RxList<Product> productsList = <Product>[].obs;
  RxList<Product> productsListProd = <Product>[].obs;
  bool isLoading = true;
  List<Product> productList = [];
  Box<Product>? productBox;
  @override
  void onInit() async {
    selectedChip = 0;
    controller = new TabController(vsync: this, length: 3);
    myHandler = _tabs[0].obs;
    controller.addListener(_handleSelected);
   
     productBox = Hive.box<Product>(productBoxName);
    //FirebaseAdMob.instance.initialize(appId:"ca-app-pub-8772568690813006~5906019215");
   
    /*----------------*/
    PhotoProvider().getPhotoList(
      onSuccess: (photo) {
        productsList.addAll(photo);
        productsListProd.addAll(photo);
        getChipProduct(productChip.values[0]);
        isLoading = false;
        update();
      },
      onError: (error) {
        isLoading = false;
        update();
        print("Error");
      },
      beforeSend: () {},
    );
    super.onInit();
  }

  void _handleSelected() {
    myHandler.value = _tabs[controller.index];
  }

  @override
  void dispose() {
    super.dispose();
  }

  addProduct(prod, context) async {
    productBox!.add(prod);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Enregistré dans favoris')));
  }

 void removeProduct(int id) async {
    productBox!.deleteAt(id);
    print("succes");
  }

  List<dynamic> getChipProduct(productChip chip) {
    
    switch (chip) {
      case productChip.TOUT:
        productsList.value = productsListProd.toList()..shuffle();
        return productsList;

      case productChip.RECENT:
        productsList.value = productsListProd.reversed.toList();
        return productsList;

      case productChip.MIEUX_NOTE:
        productsList.value =
            productsListProd.where((o) => o.note! >= 3).toList();
        return productsList;

      case productChip.ALEATOIRE:
        productsList.value = productsListProd.reversed.toList();
        return productsList;
    }
    update();
    return productsList;
  }
}
