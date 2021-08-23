

import 'package:connectivity/connectivity.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'custom_widgets/snackBar_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utility{
  static showConnectivitySnackBar(ConnectivityResult result, BuildContext context){
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? 'You have again ${result.toString()}'
        : 'You have no Internet';
    final color = hasInternet ? COLOR_GREEN : COLOR_RED;
    CustomSnackBar.showTopSnackBar(context, 'Internet Connectivity Status', message, color);
    //SnackBar.showTopSnackBar(context, msg, color);
  }

  String formatCurrency(num amount, {int decimalCount = 0}){
    final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: decimalCount);
    return formatCurrency.format(amount);
  }
}