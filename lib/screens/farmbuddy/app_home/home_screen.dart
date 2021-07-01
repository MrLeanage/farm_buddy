import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:farm_buddy/screens/common/components/base_widget.dart';
import 'package:farm_buddy/screens/common/components/border_box.dart';
import 'package:farm_buddy/screens/common/components/side_bar.dart';
import 'package:farm_buddy/screens/common/popups/dialogs.dart';
import 'package:farm_buddy/screens/farmbuddy/encyclopaedia/encyclopaedia.dart';
import 'package:farm_buddy/screens/farmbuddy/project/project.dart';
import 'package:farm_buddy/screens/farmbuddy/settings/settings.dart';
import 'package:farm_buddy/screens/farmbuddy/shop/shop.dart';
import 'package:farm_buddy/services/auth.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/widget_functions.dart';
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

  int index = 0;
  List<Widget> list = [
    HomeScreen(),
    Settings(),
    Shop(),
    Project(),
    Encyclopaedia()

  ];

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    Dialogs dialog = new Dialogs();
    double icon_size = 20;
    if(window.physicalSize.width < 500){
      icon_size = 12;
    }
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Image.asset('assets/logo-cover.png', fit: BoxFit.fill),
          actions: <Widget>[

            TextButton(
                onPressed: () async{
                  await _authService.signOut();
                  ///Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
                },
                child: Row(
                  children: <Widget>[
                    Text(
                        'Logout',
                        style: TextStyle(color: Colors.white)
                    ),
                    Icon(
                      Icons.person, color: COLOR_WHITE,
                    )
                  ],
                )
            ),
          ],
        ),
        body: Container(
            width: size.width,
            height: size.height,
            child: BaseWidget(
                child: Container(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpace(padding),
                      Padding(
                        padding: sidePadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          ],

                        ),
                      ),
                      addVerticalSpace(padding),
                      Padding(
                        padding: sidePadding,
                        child: Text("Ongoing Farming Projects", style: themeData.textTheme.headline3,),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () => dialog.information(context, "This is Dialog Info Title", "This is Dialog Info Description"),
                            child: Text(
                                'Info Dialog'
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () async {
                              dialog.waiting(context, "This is Dialog Waiting Title", "This is Dialog Waiting Description");
                              await Future.delayed(Duration(seconds: 2));
                              Navigator.pop(context);
                            },
                            child: Text(
                                'Info Dialog'
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () async {


                            },
                            child: Text(
                                'Confirm Dialog'
                            ),
                          )
                        ],
                      )
                    ],
                  ),            )


            )
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: COLOR_GREEN,
          backgroundColor: COLOR_WHITE,
          height: icon_size * 2.5,
          index: 2,
          items: <Widget>[
            Icon(Icons.eco, size: icon_size, color: COLOR_WHITE),
            Icon(Icons.add, size: icon_size, color: COLOR_WHITE),
            Icon(Icons.home, size: icon_size, color: COLOR_WHITE),
            Icon(Icons.shop, size: icon_size, color: COLOR_WHITE),
            Icon(Icons.settings, size: icon_size, color: COLOR_WHITE)
          ],
          onTap: (index){
            if(index == 0){
              Encyclopaedia();
            }
            debugPrint("current Index is : $index");
          },
        ),
        drawer: SideBar(),
      ),
    );
  }
}

