import 'dart:ui';

import 'package:farm_buddy/model/userDetail.dart';
import 'package:farm_buddy/screens/authenticate/authenticate.dart';
import 'package:farm_buddy/screens/common/components/base_widget.dart';
import 'package:farm_buddy/screens/farmbuddy/app_home/home_screen.dart';
import 'package:farm_buddy/screens/shared/loader.dart';
import 'package:farm_buddy/screens/shared/splash_screen.dart';
import 'package:farm_buddy/screens/wrapper.dart';
import 'package:farm_buddy/services/auth.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/farmbuddy/app_home/home_screen.dart';
import 'screens/authenticate/login_screen.dart';
import 'screens/authenticate/signup_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FarmBuddyApp());
}

class FarmBuddyApp extends StatelessWidget{


  @override
  Widget build(BuildContext context){
    double screenWidth = window.physicalSize.width;

    return StreamProvider<User>.value(
      value: AuthService().user,

      child: MaterialApp(
        //debugShowCheckedModeBanner: false,

        title: 'Farm Buddy',
        theme: ThemeData( primaryColor: COLOR_WHITE,  accentColor: COLOR_GREY, textTheme: screenWidth <500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT ),
        home: Wrapper(),
        //Routes
        routes:{
          SignupScreen.routeName: (ctx) => SignupScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen()
        }
      ),
    );
  }
}
