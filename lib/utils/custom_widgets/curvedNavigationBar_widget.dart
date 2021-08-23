
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:farm_buddy/screens/farmbuddy/encyclopaedia/encyclopaedia.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// ignore: non_constant_identifier_names
Widget CustomCurvedNavigationBar( double iconSize, int indexNo){


  return CurvedNavigationBar(
    height: iconSize * 2.5,
    index: indexNo,
    items: <Widget>[
      Icon(Icons.eco, size: iconSize, color: COLOR_GREEN),
      Icon(Icons.add, size: iconSize, color: COLOR_GREEN),
      Icon(Icons.home, size: iconSize, color: COLOR_GREEN),
      Icon(Icons.shop, size: iconSize, color: COLOR_GREEN),
      Icon(Icons.settings, size: iconSize, color: COLOR_GREEN)
    ],
    color: COLOR_WHITE,
    backgroundColor: COLOR_GREEN,

    letIndexChange: (index) => true,

  );
}
