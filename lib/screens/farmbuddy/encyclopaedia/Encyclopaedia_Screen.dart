import 'dart:ui';

import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/appBar.dart';
import 'package:farm_buddy/utils/custom_widgets/pageHeading_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';

class Encyclopaedia extends StatefulWidget {
  @override
  _EncyclopaediaState createState() => _EncyclopaediaState();
}

class _EncyclopaediaState extends State<Encyclopaedia> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBar(),
      backgroundColor: COLOR_BACKGROUND,

      body: Column(
        children: [
          customAppBar(size.height, size.width, _scaffoldKey),
          PageHeadingWidget("ENCYCLOPEDIA", Icons.eco, size.height, size.width),

        ],
      ),
    );
  }
}
