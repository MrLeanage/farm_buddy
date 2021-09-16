import 'dart:math';

import 'package:flutter/material.dart';

import '../constants.dart';
import 'addSpace_widget.dart';

Widget customAppBar(double screenHeight, double screenWidth, GlobalKey<ScaffoldState> _scaffoldKey){
  return Container(
    height: screenHeight * 0.045,
    width: screenWidth,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            // bottomLeft: Radius.circular(screenHeight * 0.02),
            // bottomRight: Radius.circular(screenHeight * 0.02)
        ),
        color: COLOR_WHITE,
        boxShadow: [
          BoxShadow (
              color: COLOR_BLACK.withOpacity(0.35),
              offset: new Offset(-10.0, 10.0),
              blurRadius: 20.0,
              spreadRadius: 5.0
          ),
        ]
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[

          IconButton(
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            icon: Icon(Icons.menu),
            color: COLOR_GREEN,
          ),


          Image.asset(
            'assets/logo-cover.png',
            width: screenWidth * 0.2,
          )
        ],
      ),
    ),
    padding: EdgeInsets.only(left: 15.0, right: 15.0),

  );
}