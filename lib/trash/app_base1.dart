import 'package:connectivity/connectivity.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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

  final AuthService _authService = AuthService();
  final double padding = 10;
  final sidePadding = EdgeInsets.symmetric(horizontal: 10);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PageController pageController = PageController();
  List<Widget> _screens = [
    HomeScreen(),
    Settings(),
    ShopScreen(),
    ProjectScreen(),
    Encyclopaedia()
  ];
  int index = 0;

  void _onPageChanged(int index){}



  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final Dialogs dialog = new Dialogs();
    final double screenWidth = window.physicalSize.width;
    final double screenHeight = window.physicalSize.height;
    final double contextWidth = MediaQuery.of(context).size.width;
    double iconSize = 20;
    if(screenWidth < 500){
      iconSize = 12;
    }
    return Scaffold(
        key: _scaffoldKey,
        drawer: SideBar(),
        backgroundColor: COLOR_BACKGROUND,

        body: Column(
          children: [
            customAppBar(screenHeight, screenWidth, _scaffoldKey),
            addVerticalSpace(screenHeight * 0.01),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: screenHeight * 0.065,
                    width: screenWidth * 0.27,

                    child: Stack(
                      children: [
                        Container(
                            height: screenHeight *0.1,
                            width: screenWidth * 0.8,
                            decoration: BoxDecoration(
                                color: COLOR_WHITE,
                                borderRadius: BorderRadius.circular(0.0),
                                boxShadow: [
                                  BoxShadow (
                                      color: COLOR_BLACK.withOpacity(0.35),
                                      offset: new Offset(-10.0, 10.0),
                                      blurRadius: 20.0,
                                      spreadRadius: 5.0
                                  ),
                                ]
                            )

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
        bottomNavigationBar: CustomCurvedNavigationBar(iconSize, 2)

    );
  }

}
/*

 */
