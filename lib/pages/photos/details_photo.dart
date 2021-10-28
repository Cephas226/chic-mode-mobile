import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_native_admob/flutter_native_admob.dart';
//import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getx_app/model/product_model.dart';
import 'package:getx_app/themes/color_theme.dart';
import 'package:getx_app/widget/photo_widget/photohero.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class DetailsPhoto extends StatelessWidget {
  final int index;
  final int dataLength;
  final Padding actionPanel;
  final Product product;
  const DetailsPhoto(
      {required Key key, required this.index, required this.actionPanel, required this.product, required this.dataLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
   // final _nativeAdController = NativeAdmobController();
    return Scaffold(
      //floatingActionButton: buildSpeedDial(controller,index,context),
      appBar: AppBar(
        backgroundColor: Color(0xFFF70759),
        title: const Text('Details'),
      ),

      body: CarouselSlider.builder(
        itemCount: dataLength,
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
                  photo: product.url.toString(),
                  width: double.infinity,
                  height: double.infinity,
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
            ),
            actionPanel,
          ],
        ),
      ),
    );
  }
}
