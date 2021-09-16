import 'package:connectivity/connectivity.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:farm_buddy/screens/farmbuddy/encyclopaedia/Encyclopaedia_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/project/Project_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/settings/Settings_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/shop/Shop_Screen.dart';
import 'package:farm_buddy/services/authenticate_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import '../../../trash/curvedNavigationBar_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/appBar.dart';
import 'package:farm_buddy/utils/custom_widgets/navigationBar.dart';
import 'package:farm_buddy/utils/custom_widgets/sidebar_widget.dart';
import 'package:farm_buddy/utils/popups/dialogs.dart';
import '../../../utils/custom_widgets/snackBar_widget.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'Feeds_Screen.dart';

class HomeScreen extends StatefulWidget {
  int pageNumber = 0;

  HomeScreen(this.pageNumber);

  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState(pageNumber);
}

class _HomeScreenState extends State<HomeScreen> {
  int pageNumber = 0;

  _HomeScreenState(this.pageNumber);

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  var _pageController;
  List<Widget> _screens = [
    Encyclopaedia(),
    ProjectScreen(),
    Feeds(),
    ShopScreen(),
    Settings(),
  ];
  void _onPageChanged(int index){}
  void _onItemTapped(int selectedIndex){
    print(selectedIndex);
    _pageController.jumpToPage(selectedIndex);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(
      initialPage: pageNumber,
    );
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
          index: pageNumber,
          height: iconSize * 2.5,
          items: <Widget>[
            Icon(Icons.eco, size: iconSize, color: COLOR_WHITE),
            Icon(Icons.add, size: iconSize, color: COLOR_WHITE),
            Icon(Icons.home, size: iconSize, color: COLOR_WHITE),
            Icon(Icons.shop, size: iconSize, color: COLOR_WHITE),
            Icon(Icons.settings, size: iconSize, color: COLOR_WHITE)
          ],
          color: COLOR_GREEN,
          backgroundColor: COLOR_WHITE,
          buttonBackgroundColor: COLOR_GREEN,
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
