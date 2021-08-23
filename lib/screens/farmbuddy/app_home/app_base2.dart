import 'package:connectivity/connectivity.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:farm_buddy/screens/farmbuddy/app_home/feeds.dart';
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
    Shop(),
    Project(),
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
