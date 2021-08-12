

import 'package:getx_app/model/product_model.dart';
import 'package:getx_app/services/backend_service.dart';

class PhotoProvider {
  void getPhotoList({
    Function() beforeSend,
    Function(List<Product> product) onSuccess,
    Function(dynamic error) onError,
  }) {
    ApiRequest(url: 'https://myafricanstyle.herokuapp.com/product', data: null).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        onSuccess((data as List).map((postJson) => Product.fromJson(postJson)).toList());
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
