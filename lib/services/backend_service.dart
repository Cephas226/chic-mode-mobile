import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Dataservices {
  List allProduct = [];
  static var client = http.Client();
  static Future<List> fetchProductx() async {
    final response =
    await client.get(Uri.parse("https://myafricanstyle.herokuapp.com/product"));

    if (response.statusCode == 200)
      return json.decode(response.body);
    return [];
  }
  static Future<List> fetchVideo() async {
    final response =
    await client.get(Uri.parse("https://myafricanstyle.herokuapp.com/video"));

    if (response.statusCode == 200)
      return json.decode(response.body);
    return [];
  }

}
class ApiRequest {
  final String url;
  final Map data;

  ApiRequest({
    @required this.url,
    this.data,
  });

  Dio _dio() {
    // Put your authorization token here
    return Dio(BaseOptions(headers: {
      'Authorization': 'B ....',
    }));
  }

  void get({
    Function() beforeSend,
    Function(dynamic data) onSuccess,
    Function(dynamic error) onError,
  }) {
    _dio().get(this.url, queryParameters: this.data).then((res) {
      if (onSuccess != null) onSuccess(res.data);
    }).catchError((error) {
      if (onError != null) onError(error);
    });
  }
}