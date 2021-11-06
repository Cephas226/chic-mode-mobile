
//import 'package:firebase_admob/firebase_admob.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_native_admob/flutter_native_admob.dart';
//import 'package:flutter_native_admob/native_admob_controller.dart';
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
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'dart:math' as math;
import 'package:transparent_image/transparent_image.dart';
import 'package:http/http.dart' as http;

class CategoriesPage extends GetView<CategoriesController> {
  late List homme;
  late List femme;
  late List couple;
  late List enfant;
  final CategoriesController _catController = Get.put(CategoriesController());
  final HomeController _prodController = Get.put(HomeController());
  //final _nativeAdController = NativeAdmobController();
  Widget _gestureDetector(
      BuildContext context, String param2, String assetUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (BuildContext context) {
          return WillPopScope(child: Scaffold(
            appBar: AppBar(
              title: const Text('Photo'),
              backgroundColor: Color(0xFFF70759),
              leading: new IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: () async {
                 _catController.showInterstitialAd();
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
                          productsListCritere = controller.productsList.reversed
                              .where((o) => o.categorie == param2)
                              .toList()
                            ..shuffle();
                    

                          return LoadingOverlay(
                              isLoading: controller.isLoading,
                              child: GridView.builder(
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
                                  itemBuilder: (BuildContext context,
                                          int index) =>
                                      GestureDetector(
                                        onTap: (() => Get.off(builDetailBody(
                                            controller,
                                            index,
                                            context,
                                            productsListCritere))),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadiusDirectional
                                                      .circular(20)),
                                          clipBehavior: Clip.antiAlias,
                                          child: CachedNetworkImage(imageUrl: 
                                              productsListCritere[index].url),
                                        ),
                                      )));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ), onWillPop:(){
          return  _catController.showInterstitialAd();
          });
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
