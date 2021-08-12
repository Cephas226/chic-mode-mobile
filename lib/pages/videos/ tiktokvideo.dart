import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:getx_app/model/tiktok.dart';
import 'package:getx_app/model/video_model.dart';
import 'package:getx_app/widget/videoPlayer.dart';


class TikTokVideox extends StatelessWidget {
  final Video video;

  const TikTokVideox({@required this.video});
  @override
  Widget build(BuildContext context) {
    final _nativeAdController = NativeAdmobController();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TikTokVideoPlayer(url: video.url[0]),
        ],
      ),
    );
  }
}