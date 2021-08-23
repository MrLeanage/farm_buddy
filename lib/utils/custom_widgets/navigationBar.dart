import 'package:flutter/material.dart';

import '../constants.dart';

Widget CustomNavigationBar(PageController pageController, List<Widget> screens, double iconSize, int indexNo){
  return Scaffold(
    body: PageView(
      controller: pageController,
      children: screens,
      //onPageChanged: _onPageChanged,
      physics: NeverScrollableScrollPhysics(),
    ),
    bottomNavigationBar: BottomNavigationBar(items: [
      BottomNavigationBarItem(

        icon: Icon(
            Icons.eco,
            color: COLOR_GREY
        ),
        title: Text('Home'),

      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.add, color: COLOR_GREY),
          title: Text('Home')
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.home, color: COLOR_GREEN),
          title: Text('Home')
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.shop, color: COLOR_GREY),
          title: Text('Home')
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.settings, color: COLOR_GREY),
          title: Text('Home')
      )
    ]),
  );
}