import 'package:farm_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  final Widget child;

  const BaseWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: COLOR_WHITE
          ),
          child: Container(

            decoration: BoxDecoration(
              color: COLOR_WHITE,
              border: Border.all(
                color: COLOR_WHITE,
                width: 5,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
              child: Center(child: child)
          ),
        ),
      ),
    );
  }
}
