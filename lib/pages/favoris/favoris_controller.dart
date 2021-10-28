import 'package:get/get.dart';
import 'package:getx_app/model/product_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavorisController extends GetxController {
  //var box;
  String productBoxName = 'product';
  final String title = 'Accueil';
  List<Product> allProduct = [];
 List<Product> productList = [];
  Box<Product>? productBox;
  var valueListenable;
  @override
  void onInit() async{
    super.onInit();
    getFavProduct();
    productBox = Hive.box<Product>(productBoxName);
    valueListenable=Hive.box<Product>(productBoxName).listenable();
  }
  @override
  void dispose() {
    super.dispose();
  }
  Future<List<Product>> getFavProduct() async {
    if (productBox!=null){
      for (int i = 0; i < productBox!.length; i++) {
        var prodMap = productBox!.getAt(i);
        Product tmp = Product();
        tmp.productId = prodMap!.productId;
        tmp.categorie = prodMap.categorie;
        tmp.url = prodMap.url;
        productList.add(tmp);
      }
    }
    return productList;
  }
  void removeProduct(int id) async{
    productBox!.deleteAt(id);
    print("succes");
  }
}