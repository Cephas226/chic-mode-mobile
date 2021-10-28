import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter_native_admob/flutter_native_admob.dart';
//import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';
import 'package:getx_app/model/product_model.dart';
class PhotoListItem extends StatelessWidget {
  final Product product;
  final int index;
  //final int dataLength;
  final Widget toolBar;
  //final Padding actionPanel;
  final Widget detailBody;
  const PhotoListItem({required this.product,required this.toolBar,required this.index,
    //required this.dataLength,
    //required this.actionPanel,
    required this.detailBody
  });

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
                    child:  CachedNetworkImage(imageUrl: product.url.toString()),
                  ),
                ),
                toolBar
              ],
            )
        ),
      );
  }
}
