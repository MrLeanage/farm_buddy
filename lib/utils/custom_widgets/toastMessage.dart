
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class ToastMessage{
  ToastMessage.showErrorToast(String msg){
    Fluttertoast.showToast(
        msg:msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  ToastMessage.showSuccessToast(String msg){
    Fluttertoast.showToast(
        msg:msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.teal,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
