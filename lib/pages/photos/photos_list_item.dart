import 'package:carousel_slider/carousel_slider.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';
import 'package:getx_app/model/product_model.dart';
import 'package:getx_app/themes/color_theme.dart';
import 'package:getx_app/widget/photo_widget/photohero.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:math' as math;
import 'details_photo.dart';
class PhotoListItem extends StatelessWidget {
  final Product product;
  final int index;
  final int dataLength;
  final Widget toolBar;
  final Padding actionPanel;
  final Widget detailBody;
  const PhotoListItem({Key key, this.product,this.toolBar,this.index,this.dataLength,this.actionPanel,this.detailBody}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
                Radius.circular(12))),
        child:
        ClipRRect(
            borderRadius:
            BorderRadius.all(Radius.circular(12)),
            child:
            Stack(
              clipBehavior: Clip.none, fit: StackFit.passthrough,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(()=>detailBody);
                  },
                  child:
                  /*Card(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadiusDirectional
                            .circular(20)),
                    clipBehavior: Clip.antiAlias,
                    child:  PhotoHero(
                      photo:product.url,
                    ),
                  ),*/
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadiusDirectional
                            .circular(20)),
                    clipBehavior: Clip.antiAlias,
                    child:  Image.network(product.url),
                  ),
                ),
                toolBar
              ],
            )
        ),
      );
  }
}