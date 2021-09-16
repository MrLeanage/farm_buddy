import 'package:farm_buddy/main.dart';
import 'package:farm_buddy/model/userDetail.dart';
import 'package:farm_buddy/screens/authenticate/authenticate.dart';
import 'farmbuddy/app_home/AppBase_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //return either home or authenticate widget
    print('user from wrapper build started');
    final user = Provider.of<User>(context);
    print( user);
    if(user == null){
      print('called wrapper inside');
      return Authenticate();
    }else{
      print('called wrapper inside');
      return HomeScreen(2);
    }
  }
}
