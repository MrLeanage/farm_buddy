import 'package:flutter/material.dart';

import '../constants.dart';
import 'addSpace_widget.dart';

// ignore: non_constant_identifier_names
Widget PageHeadingWidget(String heading, IconData iconData, double screenHeight, double screenWidth){
  return SingleChildScrollView(
    child: Column(
      children: [
        addVerticalSpace(screenHeight * 0.005),
        Container(
          //height: screenHeight * 0.065,
          //width: screenWidth * 0.27,
          height: screenHeight *0.025,
          width: screenWidth * 0.27,
          decoration: BoxDecoration(
              color: COLOR_WHITE,
              boxShadow: [
                BoxShadow (
                    color: COLOR_BLACK.withOpacity(0.35),
                    offset: new Offset(-10.0, 10.0),
                    blurRadius: 20.0,
                    spreadRadius: 5.0
                ),
              ],
            gradient: LinearGradient(
                colors: [
                  COLOR_GREEN,
                  COLOR_YELLOW
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    addHorizontalSpace(screenWidth * 0.01),
                    Icon(iconData, color: COLOR_WHITE),
                    addHorizontalSpace(screenWidth * 0.01),
                    Text(heading, style: TextStyle(
                        color: COLOR_WHITE,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    )),
                  ],
                )
              ],
            ),
          ),


        ),
        addVerticalSpace(screenHeight * 0.004)
      ],
    ),
  );
}