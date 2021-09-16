



import 'package:cloud_firestore/cloud_firestore.dart';
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
  
  static List<String> listBuilderFromJson(var jsonList){
    List<String> list = [];
    for(var json in jsonList){
      list.add(json.toString());
    }
    return list;
  }

  static String convertTimeStampToDate(var json){
    String formatDate = "Not Available";
    //int seconds = 1631290360;
    int constant = 1000;

      // try{
      //   seconds = json['seconds'];
      //   seconds = json['seconds'];
      // }catch(Exception){
      //   Exception.toString();
      // }
      if(json != null){
        if(json['_seconds'] != 0){
          print("Key  contain");
          print("dates :"+ json['_seconds'].toString());
          int seconds = json['_seconds'].toInt();
          DateTime date = DateTime.fromMillisecondsSinceEpoch( (seconds * constant).toInt());
          formatDate = DateFormat('yyyy-MM-dd').format(date);
          print("dates : "+ formatDate);
        }else{
          print("dates :"+ json['seconds'].toString());
          print("Key available Seconds not available");
        }
      }else{
        print("Key not contain");
      }

      // print("value : "+(seconds*constant).toString() );




    // try{
    //
    // }catch(Exception){
    //   formatDate = "Not Available";
    // }
    return formatDate;
  }

}