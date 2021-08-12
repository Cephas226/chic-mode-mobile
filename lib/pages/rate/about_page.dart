import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/home/home_controller.dart';
import 'package:getx_app/pages/home/home_page.dart';
import 'package:getx_app/pages/photos/loading_overlay.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:getx_app/themes/color_theme.dart';
import 'package:getx_app/widget/photo_widget/photohero.dart';
import 'rate_controller.dart';

class AboutPage extends GetView<RateController> {
  CarouselController carouselController = new CarouselController();
  final _nativeAdController = NativeAdmobController();
  List<String> imageList = [];
  var currentPos = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF70759),
        title: Text("A propos de l'application"),
        actions: [
          IconButton(
              onPressed: () => {showRatingAppDialog(context)},
              icon: Icon(Icons.star_rate_outlined))
        ],
      ),
      body:SingleChildScrollView(
        child:
        Container(
          alignment: Alignment.center,
          child:
          Column(
            children: [
              Card(
                child: ListTile(
                  leading: Image.asset("assets/avatar.png"),
                  title: Text("Chic Mode"),
                  subtitle: Text(
                    "Version \n 1.0",
                    style: TextStyle(color: Colors.black26),
                  ),
                ),
              ),
              Card(
                  margin: EdgeInsets.all(30),
                  child: Padding(
                      padding:EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Row(
                            children: [Icon(Icons.info_outlined,color: Color(0xFFF70759),), Text("A propos de Chic Mode",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20))],
                          ),
                          SingleChildScrollView(
                            child:
                            Text(
                              "\nAvec chic mode, trouvez des modèles de vêtements n'a jamais été aussi simple\n" +
                                  "Nous vous proposons différentes catégories de modèles\n"+
                                  "\nFemmes: toute une panoplie de modèles disponibles pour vous mesdames en fonction de vos goûts et de votre morphologie.\n" +

                                  "\nHommes: des modèles élégants pour assurer l'elegance de nos messieurs\n" +

                                  "\nCouples: pour vos uniformes de mariage, dot ou tout simplement si vous souhaitez vous habillez avec le même pagne que votre partenaire\n" +

                                  "\nEnfants : retrouvez de jolies modèles pour vos boudchous.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 18.0),
                              maxLines: 100,
                            ),
                          )
                        ],
                      )))
            ],
          ),
        ),
      )
    );
  }
}
