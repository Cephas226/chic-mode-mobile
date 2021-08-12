import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/categories/categories_controller.dart';
import 'package:getx_app/pages/dashboard/dashboard_page.dart';
import 'package:getx_app/pages/home/home_controller.dart';
import 'package:getx_app/pages/home/home_page.dart';
import 'package:getx_app/pages/photos/loading_overlay.dart';
import 'package:getx_app/pages/photos/photos_list_item.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:getx_app/themes/color_theme.dart';
import 'package:getx_app/widget/photo_widget/photohero.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'dart:math' as math;
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;

class CategoriesPage extends GetView<CategoriesController> {
  List homme;
  List femme;
  List couple;
  List enfant;
  final CategoriesController _catController = Get.put(CategoriesController());
  final HomeController _prodController = Get.put(HomeController());
  final _nativeAdController = NativeAdmobController();
  Widget _gestureDetector(
      BuildContext context, String param2, String assetUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Photo'),
              backgroundColor: Color(0xFFF70759),
              leading: new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: () async {
                    print("cooly");
                    _prodController.createInterstitialAd()
                      ..load()
                      ..show().then((value) => Get.to(() => DashboardPage()));
                  }),
              /*;*/
            ),
            body: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      child: GetBuilder<HomeController>(
                        builder: (controller) {
                          List productsListCritere;
                          productsListCritere= controller.productsList.reversed
                              .where((o) => o.categorie == param2)
                              .toList()
                          ;
                          print(controller.productsList);

                          return  LoadingOverlay(
                              isLoading: controller.isLoading,
                              child:
                             GridView.builder(
                                  itemCount: productsListCritere.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        MediaQuery.of(context).orientation ==
                                                Orientation.landscape
                                            ? 3
                                            : 3,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          GestureDetector(
                                            onTap: (()=>Get.to(builDetailBody(
                                                controller,
                                                index,
                                                _nativeAdController,context))),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(20)),
                                              clipBehavior: Clip.antiAlias,
                                              child:  Image.network(productsListCritere[index].url),

                                            ),
                                          )
                             ));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
      },
      child: Stack(
        children: [
          Card(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage(assetUrl), fit: BoxFit.cover)),
              child: Transform.translate(
                offset: Offset(50, -50),
                child: Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent),
                ),
              ),
            ),
          ),
          Positioned(
            left: 80,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Center(
              child: Text(
                param2,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Raleway',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Catégories",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(1),
          children: <Widget>[
            _gestureDetector(context, "Homme", "assets/a.jpg"),
            _gestureDetector(context, "Femme", "assets/b.jpg"),
            _gestureDetector(context, "Couple", "assets/c.jpg"),
            _gestureDetector(context, "Enfant", "assets/d.jpg")
          ],
        ),
      ),
    );
  }
}

_saveImage(url, name, context) async {
  if (await Permission.storage.request().isGranted) {
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.bodyBytes),
        quality: 60,
        name: "model" + name.toString());
    print(result["filePath"]);
    Share.shareFiles(
        [result['filePath'].toString().replaceAll(RegExp('file://'), '')],
        text:
            'Pour plus de modèles de pagnes, télécharges l\'application ChicMode via ce lien 👉🏼 https://bit.ly/chicmode');
  } else if (await Permission.storage.request().isPermanentlyDenied) {
    await openAppSettings();
  } else if (await Permission.storage.request().isDenied) {}
}

_shareImage(url, name, context) async {
  if (await Permission.storage.request().isGranted) {
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.bodyBytes),
        quality: 60,
        name: "model" + name.toString());
    print(result["filePath"]);
    Share.shareFiles(
        [result['filePath'].toString().replaceAll(RegExp('file://'), '')],
        text:
            'Pour plus de modèles de pagnes, télécharges l\'application ChicMode via ce lien 👉🏼 https://bit.ly/chicmode');
  } else if (await Permission.storage.request().isPermanentlyDenied) {
    await openAppSettings();
  }
}
Widget _builDetailBody(controller, index, nativeAdController,context) {
  return Scaffold(
    floatingActionButton: buildSpeedDial(controller,index,context),
    appBar: AppBar(
      backgroundColor: Color(0xFFF70759),
      title: const Text('Details'),
    ),
    body: CarouselSlider.builder(
      itemCount: controller.productsList.length,
      options: CarouselOptions(
        height: 800,
        scrollDirection: Axis.vertical,
        initialPage: index,
        viewportFraction: 1,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: false,
        autoPlay: false,
      ),
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
          Stack(
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(20)),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: const EdgeInsets.all(0.0),
                  height: double.infinity,
                  color: Color(0xFFF70759),
                  child: PhotoHero(
                    photo: controller.productsList[itemIndex].url,
                    width: double.infinity,
                    height: double.infinity,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
              ),
              /*_buildBarDetail(context, controller, index),*/
              Positioned.fill(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.all(8),
                      height: 90,
                      color: Colors.white24,
                      child: NativeAdmob(
                        adUnitID: banniereUnitID,
                        controller: nativeAdController,
                        type: NativeAdmobType.full,
                        loading: Center(child: CircularProgressIndicator()),
                        error: Text('failed to load'),
                      ),
                    )),
              ),
            ],
          ),
    ),
  );
}