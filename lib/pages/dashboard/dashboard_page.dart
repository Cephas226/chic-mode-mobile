import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/pages/categories/categories_page.dart';
import 'package:getx_app/pages/favoris/favoris_page.dart';
import 'package:getx_app/pages/home/home_page.dart';
 
import 'package:getx_app/widget/oval-right-clipper.dart';
import '../../main.dart';
import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return
          Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomePage(),
                CategoriesPage(),
                FavorisPage(),
             //   AccountPage(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.redAccent,
            onTap: controller.changeTabIndex,
            currentIndex: controller.tabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              _bottomNavigationBarItem(
                icon: CupertinoIcons.home,
                label: 'Accueil',
              ),
              _bottomNavigationBarItem(
                icon: Icons.list,
                label: 'Catégories',
              ),
             _bottomNavigationBarItem(
                icon: CupertinoIcons.heart,
                label: 'Favoris',
              ),
            ],
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({required IconData icon, required String label}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildDrawer();
  }
}

_buildDrawer() {

  final String image = "https://firebasestorage.googleapis.com/v0/b/africanstyle-15779.appspot.com/o/avatar.png?alt=media&token=664ebc08-a844-4ba0-8345-8bbf8fc4589a";
  return ClipPath(
    clipper: OvalRightBorderClipper(),
    child: Drawer(
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 40),
        decoration: BoxDecoration(
            color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
        width: 300,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: active,
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 90,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [Colors.pink, Colors.deepPurple])),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(image),
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "@ChicMode",
                  style: TextStyle(color: active, fontSize: 16.0),
                ),
                SizedBox(height: 30.0),
                _buildRow(Icons.home, "Accueil",HomePage()),
                _buildDivider(),
                _buildRow(Icons.bookmark, "Mes favoris",FavorisPage()),
                _buildDivider(),
                _buildRow(Icons.email, "Nous contacter",CategoriesPage()),
                _buildDivider(),
                _buildRow(Icons.phone_android_outlined, "Nos applications",FavorisPage()),
                _buildDivider(),
                _buildRow(Icons.info_outline,"Aide", FavorisPage()),
                _buildDivider(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Divider _buildDivider() {
  return Divider(
    color: active,
  );
}

Widget _buildRow(IconData icon, String title,route) {
  final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: InkWell(
      onTap: () {
        Get.to(()=>route);
      },
      child: Row(children: [
        Icon(
          icon,
          color: active,
        ),
        SizedBox(width: 10.0),
        Text(
          title,
          style: tStyle,
        ),
        Spacer(),
      ]),
    ),
  );
}
