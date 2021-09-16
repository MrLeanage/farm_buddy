import 'dart:ui';

import 'package:farm_buddy/screens/farmbuddy/app_home/AppBase_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/project/Project_Screen.dart';
import 'utils/custom_widgets/loader_widget.dart';
import 'screens/wrapper.dart';
import 'package:farm_buddy/services/authenticate_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'screens/authenticate/login_screen.dart';
import 'screens/authenticate/signup_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FarmBuddyApp());
}
class FarmBuddyApp extends StatefulWidget {
  @override
  _FarmBuddyAppState createState() => _FarmBuddyAppState();
}

class _FarmBuddyAppState extends State<FarmBuddyApp> {
  double screenWidth = window.physicalSize.width;
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User>.value (

      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

          title: 'Farm Buddy',
          theme: ThemeData(primaryColor : COLOR_GREEN, accentColor: COLOR_GREY, textTheme: screenWidth <500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT ),
          home: Wrapper(),
          //Routes
          routes:{
            SignupScreen.routeName: (ctx) => SignupScreen(),
            LoginScreen.routeName: (ctx) => LoginScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(2),
            ProjectScreen.routeName: (ctx) => ProjectScreen()
          }
      ),

    );
  }
}

// ignore: must_be_immutable
// class FarmBuddyApp extends StatelessWidget{
//   double screenWidth = window.physicalSize.width;
//
//   @override
//   Widget build(BuildContext context){
//
//
//     return StreamProvider<User>.value (
//       value: AuthService().user,
//       child: MaterialApp(
//         //debugShowCheckedModeBanner: false,
//
//           title: 'Farm Buddy',
//           theme: ThemeData( primaryColor: COLOR_WHITE,  accentColor: COLOR_GREY, textTheme: screenWidth <500 ? TEXT_THEME_SMALL : TEXT_THEME_DEFAULT ),
//           home: Wrapper(),
//           //Routes
//           routes:{
//             SignupScreen.routeName: (ctx) => SignupScreen(),
//             LoginScreen.routeName: (ctx) => LoginScreen(),
//             HomeScreen.routeName: (ctx) => HomeScreen()
//           }
//       ),
//
//     );
//   }
// }
