import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart'; 
import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:getx_app/model/product_model.dart';
import 'package:getx_app/pages/favoris/favoris_controller.dart';
import 'package:getx_app/pages/home/home_controller.dart';
import 'package:getx_app/pages/home/home_page.dart';
import 'package:getx_app/themes/color_theme.dart';
import 'package:getx_app/widget/photo_widget/photohero.dart';
import 'dart:math' as math;

import 'package:hive/hive.dart';

final FavorisController _favController = Get.put(FavorisController());
final snackBar = SnackBar(content: Text('Image retirée avec succès'));
 
final HomeController homeController = Get.put(HomeController());
class FavorisPage extends GetView<FavorisController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favoris",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: _builListView(),
    );
  }
}
Widget builDetailBodyFav(controller, index, nativeAdController,context,data) {
  return Scaffold(
    floatingActionButton: buildSpeedDial(controller,index,context),
    appBar: AppBar(
      backgroundColor: Color(0xFFF70759),
      title: const Text('Details'),
    ),
    body: CarouselSlider.builder(
      itemCount: data.length,
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
                    photo: data[itemIndex].url,
                    width: double.infinity,
                    height: double.infinity,
                    onTap: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            ],
          ),
    ),
  );
}
Widget _builListView() {
  return ValueListenableBuilder(
    valueListenable: _favController.valueListenable,
    builder: (context, box, _) {
      if (Hive.box<Product>('product').values.length == 0)
        return Center(
          child: Text("Aucune image"),
        );
      return ListView.builder(
        primary: true,
        padding: EdgeInsets.only(bottom: 95),
        itemCount: Hive.box<Product>('product').length,
        itemBuilder: (context, int index) {
          Product? product = Hive.box<Product>('product').getAt(index);
          return GestureDetector(
              child: ClipRRect(
            child: Stack(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(20)),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    //height: double.infinity,
                    color: Color(0xFFF70759),
                    child: PhotoHero(
                      photo: product!.url.toString(),
                      width: double.infinity,
                      onTap: ()=>{},
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 20,
                  child: Container(
                    child: Row(
                      children: [
                        product.favorite == false?
                        IconButton(
                            onPressed: () => {},
                            icon: FavoriteButton(
                                iconSize: 40,
                                isFavorite: true,
                                valueChanged: (_isFavorite) {
                                  if (!_isFavorite) {
                                    Get.defaultDialog(
                                        title: "Confirmation",
                                        middleText:
                                            "Voulez vous vraiment retirer cette image ?",
                                        backgroundColor: Colors.white,
                                        titleStyle:
                                            TextStyle(color: Colors.black),
                                        middleTextStyle:
                                            TextStyle(color: Colors.black),
                                        confirm: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary:
                                                  Colors.red, //, // foreground
                                            ),
                                            onPressed: () => {
                                                  _favController
                                                      .removeProduct(index),
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar),
                                                  Get.back()
                                                },
                                            child: Text("Confirmez")),
                                        cancel: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .black, //, // foreground
                                            ),
                                            onPressed: () {
                                              _isFavorite=true;
                                              Get.back();
                                            },
                                            child: Text("Annulez",
                                                style: TextStyle(
                                                    color: Colors.white))));
                                  }
                                })):IconButton(
                            onPressed: () => {},
                            icon: FavoriteButton(
                                iconSize: 40,
                                isFavorite: true,
                                valueChanged: (_isFavorite) {
                                  if (!_isFavorite) {
                                    Get.defaultDialog(
                                        title: "Confirmation",
                                        middleText:
                                        "Voulez vous vraiment retirer cette image ?",
                                        backgroundColor: Colors.white,
                                        titleStyle:
                                        TextStyle(color: Colors.black),
                                        middleTextStyle:
                                        TextStyle(color: Colors.black),
                                        confirm: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary:
                                              Colors.red, //, // foreground
                                            ),
                                            onPressed: () => {
                                              _favController
                                                  .removeProduct(index),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar),
                                              Get.back()
                                            },
                                            child: Text("Confirmez")),
                                        cancel: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors
                                                  .black, //, // foreground
                                            ),
                                            onPressed: () {
                                              _isFavorite=true;
                                              Get.back();
                                            },
                                            child: Text("Annulez",
                                                style: TextStyle(
                                                    color: Colors.white))));
                                  }
                                })),
                      ],
                    ),
                    decoration: new BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                  ),
                ),
              ],
            ),
          ));
        },
      );
    },
  );
}

Widget cancelBtn() {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.black, //, // foreground
      ),
      onPressed: () {
        Get.back();
      },
      child: Text("Annulez", style: TextStyle(color: Colors.white)));
}