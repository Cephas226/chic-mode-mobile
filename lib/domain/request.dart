import 'package:http/http.dart' as http;

const urlBase = 'https://myafricanstyle.herokuapp.com/';

class Request{
  final String url;
  final dynamic body;

  Request({required this.url,this.body});

  Future<http.Response> post() {
    return http.post(Uri.parse(urlBase+url), body: body).timeout(Duration(minutes: 2));
  }

  Future<http.Response> get(){
    return http.get(Uri.parse(urlBase+url)).timeout(Duration(minutes: 2));
  }
}
class RequestController {
  String uri =
      "https://myafricanstyle.herokuapp.com/video";
}
