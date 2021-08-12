import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:getx_app/pages/home/home_page.dart';
import 'package:getx_app/services/backend_service.dart';
import 'package:getx_app/widget/photo_widget/photohero.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
class TabBarWidget extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> children;
  final ValueChanged<int> onTap;

  const TabBarWidget({
    Key key,
    @required this.tabs,
    @required this.children,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
            ),
            toolbarHeight: 80,
            bottom: TabBar(
              onTap: onTap,
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              tabs: tabs,
            ),
            elevation: 20,
            titleSpacing: 20,
          ),
          body: SafeArea(child: TabBarView(children: children)),
        ),
      );
}
