import 'package:connectivity/connectivity.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:farm_buddy/screens/farmbuddy/app_home/Feeds_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/encyclopaedia/Encyclopaedia_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/project/Project_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/settings/Settings_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/shop/Shop_Screen.dart';
import 'package:farm_buddy/services/authenticate_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'curvedNavigationBar_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/appBar.dart';
import 'package:farm_buddy/utils/custom_widgets/navigationBar.dart';
import 'package:farm_buddy/utils/custom_widgets/sidebar_widget.dart';
import 'package:farm_buddy/utils/popups/dialogs.dart';
import '../utils/custom_widgets/snackBar_widget.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //final AuthService _authService = AuthService();
  //final double padding = 10;
  //final sidePadding = EdgeInsets.symmetric(horizontal: 10);
  //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController _pageController = PageController();
  List<Widget> _screens = [
    Feeds(),
    Settings(),
    ShopScreen(),
    ProjectScreen(),
    Encyclopaedia()
  ];
  int index = 0;

  void _onPageChanged(int index){}
  void _onItemTapped(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: COLOR_BACKGROUND,
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),

        bottomNavigationBar: CustomCurvedNavigationBar(12.0, 2)

    );
  }

}
/*

 */
