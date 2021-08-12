import 'dart:convert';

import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product {

  @HiveField(0)
  int productId;

  @HiveField(1)
  String url;

  @HiveField(2)
  int vues;

  @HiveField(3)
  int note;

  @HiveField(4)
  String categorie;

  @HiveField(5)
  bool favorite;

  Product({this.productId, this.url,this.vues, this.note, this.categorie, this.favorite});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["productId"],
    url: json["url"],
    vues: json["vues"],
    note: json["note"],
    categorie: json["categorie"],
    favorite: json["favorite"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "url": url,
    "vues": vues,
    "note": note,
    "categorie": categorie,
    "favorite":favorite
  };
  List<Product> productFromJson(String str) =>
      List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

  String todoToJson(List<Product> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
  @override
  String toString() {
    return '{productId: $productId, url: $url,vues:$vues,note:$note,categorie:$categorie,favorite:$favorite}';
  }
}
class MyTabs {
  String title;
  MyTabs({this.title});
}

enum productChip { TOUT, RECENT,MIEUX_NOTE, ALEATOIRE }