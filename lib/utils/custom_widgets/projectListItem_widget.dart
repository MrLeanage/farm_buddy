import 'package:flutter/material.dart';

import '../constants.dart';
import 'addSpace_widget.dart';

// ignore: non_constant_identifier_names
Widget PageHeadingWidget(String heading, IconData iconData, double screenHeight, double screenWidth){
  return SingleChildScrollView(
    child: Column(
      children: [
        //addVerticalSpace(screenHeight * 0.003),
        Container(
          //height: screenHeight * 0.065,
          //width: screenWidth * 0.27,
          height: screenHeight *0.3,
          width: screenWidth * 0.2,
          decoration: BoxDecoration(
              color: COLOR_WHITE,
              borderRadius: BorderRadius.circular(screenWidth * 0.005),
              boxShadow: [
                BoxShadow (
                    color: COLOR_BLACK.withOpacity(0.15),
                    offset: new Offset(-10.0, 10.0),
                    blurRadius: 10.0,
                    spreadRadius: 3.0
                ),
              ]
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    addHorizontalSpace(screenWidth * 0.01),
                    Icon(iconData, color: COLOR_GREEN),
                    addHorizontalSpace(screenWidth * 0.01),
                    Text(heading, style: TextStyle(
                        color: COLOR_GREEN,
                        fontWeight: FontWeight.bold,
                        fontSize: 30
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