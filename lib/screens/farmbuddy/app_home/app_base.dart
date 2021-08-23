import 'package:connectivity/connectivity.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:farm_buddy/screens/farmbuddy/encyclopaedia/encyclopaedia.dart';
import 'package:farm_buddy/screens/farmbuddy/project/project.dart';
import 'package:farm_buddy/screens/farmbuddy/settings/settings.dart';
import 'package:farm_buddy/screens/farmbuddy/shop/shop.dart';
import 'package:farm_buddy/services/authenticate_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/curvedNavigationBar_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/appBar.dart';
import 'package:farm_buddy/utils/custom_widgets/navigationBar.dart';
import 'package:farm_buddy/utils/custom_widgets/sidebar_widget.dart';
import 'package:farm_buddy/utils/popups/dialogs.dart';
import '../../../utils/custom_widgets/snackBar_widget.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'feeds.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  PageController _pageController = PageController();
  List<Widget> _screens = [
    Encyclopaedia(),
    Project(),
    Feeds(),
    Shop(),
    Settings(),
  ];
  void _onPageChanged(int index){}
  void _onItemTapped(int selectedIndex){
    print(selectedIndex);
    _pageController.jumpToPage(selectedIndex);
  }


  @override
  Widget build(BuildContext context) {
    final double screenWidth = window.physicalSize.width;
    final double screenHeight = window.physicalSize.height;
    double iconSize = 20;
    if(screenWidth < 500){
      iconSize = 12;
    }
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 2,
          height: iconSize * 2.5,
          items: <Widget>[
            Icon(Icons.eco, size: iconSize, color: COLOR_GREEN),
            Icon(Icons.add, size: iconSize, color: COLOR_GREEN),
            Icon(Icons.home, size: iconSize, color: COLOR_GREEN),
            Icon(Icons.shop, size: iconSize, color: COLOR_GREEN),
            Icon(Icons.settings, size: iconSize, color: COLOR_GREEN)
          ],
          color: COLOR_WHITE,
          backgroundColor: COLOR_GREEN,
          buttonBackgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _onItemTapped(index);
            });
          },
          letIndexChange: (index) => true,
        ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),

      )
    );
  }

}
/*

 */
