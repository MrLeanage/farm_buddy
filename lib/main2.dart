import 'dart:ui';

import 'package:farm_buddy/model/userDetail.dart';
import 'package:farm_buddy/screens/authenticate/authenticate.dart';
import 'package:farm_buddy/screens/farmbuddy/app_home/AppBase_Screen.dart';
import 'utils/custom_widgets/loader_widget.dart';
import 'screens/wrapper.dart';
import 'package:farm_buddy/services/authenticate_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'screens/farmbuddy/app_home/AppBase_Screen.dart';
import 'screens/authenticate/login_screen.dart';
import 'screens/authenticate/signup_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FarmBuddyApp());
}

// ignore: must_be_immutable
class FarmBuddyApp extends StatelessWidget{
  static final String title = "Has Internet?";
  @override
  Widget build(BuildContext context) => OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.teal),
        home : Wrapper()
  )
  );

}
