import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/categories/categories_page.dart';
import 'package:getx_app/pages/favoris/favoris_page.dart';
import 'package:getx_app/pages/home/home_page.dart';
import 'package:getx_app/widget/oval-right-clipper.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'model/product_model.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'themes/app_theme.dart';
import 'package:hive_flutter/hive_flutter.dart';
final Color active = Colors.black;
final Color primary =Colors.white;
const String productBoxName = "product";
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>(productBoxName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.SPLASH_SCREEN,
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
    );
  }
}