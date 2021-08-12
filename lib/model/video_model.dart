import 'dart:convert';

import 'package:hive/hive.dart';

class Video {

  int videoId;

  String url;

  String name;

  Video({this.videoId, this.url, this.name});

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    videoId: json["productId"],
    url: json["url"],
    name: json["name"]
  );

  Map<String, dynamic> toJson() => {
    "videoId": videoId,
    "url": url,
    "name": name
  };
  List<Video> videoFromJson(String str) =>
      List<Video>.from(json.decode(str).map((x) => Video.fromJson(x)));

  String todoToJson(List<Video> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  @override
  String toString() {
    return 'Video{videoId: $videoId, url: $url, name: $name}';
  }
}