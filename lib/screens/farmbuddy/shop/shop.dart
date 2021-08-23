import 'dart:ui';

import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/appBar.dart';
import 'package:farm_buddy/utils/custom_widgets/pageHeading_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';
class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final double screenWidth = window.physicalSize.width;
    final double screenHeight = window.physicalSize.height;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBar(),
      backgroundColor: COLOR_BACKGROUND,

      body: Column(
        children: [
          customAppBar(screenHeight, screenWidth, _scaffoldKey),
          PageHeadingWidget("SHOP",Icons.shop, screenHeight, screenWidth),

        ],
      ),
    );
  }
}

