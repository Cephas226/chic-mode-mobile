import 'dart:convert';


import 'package:flutter/material.dart';

//import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:getx_app/domain/request.dart';
import 'package:getx_app/widget/videoPlayer.dart';
import 'package:http/http.dart' as http;
class Trending extends StatefulWidget {
  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
   PageController? pageController;
  RequestController api = RequestController();
  //final _nativeAdController = NativeAdmobController();
  List<Widget> tikTokVideos = [];

  getTrending() async {
    var response = await http.get(
      Uri.parse(api.uri),
    );
    print(response.body);
    jsonDecode(response.body).forEach(
          (item) {
        setState(() {
          tikTokVideos.add(TikTokVideoPlayer(url: item["url"]));
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getTrending();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: pageController,
      children: tikTokVideos.length == 0
          ? <Widget>[
        Container(
          color: Colors.black,
          child: Center(
            child: GFLoader(
              type: GFLoaderType.circle,
              loaderColorOne: Colors.blueAccent,
              loaderColorTwo: Colors.black,
              loaderColorThree: Colors.pink,
            ),
          ),
        ),
      ]
          : tikTokVideos.reversed.toList()..shuffle(),
    );
  }
}
