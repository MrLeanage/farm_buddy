import 'package:farm_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

class BorderBox extends StatelessWidget {

  final Widget child;
  final EdgeInsets padding;
  final double width, height;

  const BorderBox({Key? key, required this.padding, required this.width, required this.height, required this.child}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(

      width: width,
      height: height,
      decoration: BoxDecoration(
        color: COLOR_WHITE,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: COLOR_GREY.withAlpha(15), width: 2)
      ),
      padding: EdgeInsets.all(5.0),
      child: Center(child: child),

    );
  }
}
