import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';


class CustomSnackBar{
  static void showTopSnackBar(
      BuildContext context,String title, String message, Color color,
      ) => showSimpleNotification(
            Text(title),
            subtitle: Text(message),
            background: color,
  );
}