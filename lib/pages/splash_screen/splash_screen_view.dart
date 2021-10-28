import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: GetBuilder<SplashScreenController>(builder: (_) {
          return
            new Scaffold(
              body: Stack(
                children: [
                  new Image.asset(
                    "assets/pagne1.jpeg",
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                  ),
                  Positioned(
                      bottom: 350.0,
                      right: 20.0,
                      left: 0.0,
                      child: Container(
                        width: 200,
                        decoration: new BoxDecoration(
                            color: Colors.black26),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Chic mode", style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w800)),
                          ],
                        ),
                      )),
                  Positioned(
                      bottom: 90.0,
                      right: 20.0,
                      left: 0.0,
                      child: Container(
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Chargement en cours", style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w800)),
                            SpinKitThreeBounce(
                              color: Colors.redAccent,
                              size: 50.0,
                            )
                          ],
                        ),
                      )),
                ],
              ),
            );
        }),
      ),
    );
  }
}
