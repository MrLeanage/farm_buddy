
import 'package:farm_buddy/screens/farmbuddy/app_home/AppBase_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/encyclopaedia/Encyclopaedia_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/project/Project_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/settings/Settings_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/shop/Shop_Screen.dart';
import 'package:farm_buddy/services/api_service.dart';
import 'package:farm_buddy/services/authenticate_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'snackBar_widget.dart';
import 'package:farm_buddy/utils/popups/dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'addSpace_widget.dart';

// ignore: must_be_immutable
class SideBar extends StatelessWidget {

  String? displayName = FirebaseAuth.instance.currentUser!.displayName;
   //SideBar({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final AuthService _authService = AuthService();
    Dialogs dialog = new Dialogs();
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.6,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: COLOR_GREEN),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 70,
                        height: 70,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/avatar.png'),

                        ),
                    ),
                    addVerticalSpace(2),
                    Text(
                        this.displayName.toString(),
                      style: TextStyle(
                        color: COLOR_WHITE,
                        fontSize: 18
                      ),
                      //'$displayName'
                    ),
                    addVerticalSpace(2),
                    Text(
                      'example@abc.com',
                      style: TextStyle(
                        color: COLOR_WHITE,
                        fontSize: 12
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => debugPrint('Taped 0')//onTap(context, 0),
            ),
            ListTile(
                leading: Icon(Icons.verified_user),
                title: Text('My Profile'),
                onTap: () => debugPrint('Taped 0')//onTap(context, 0),
            ),
            ListTile(
                leading: Icon(Icons.logout),
                title: Text('Sign Out'),
                onTap: () => dialog.confirm(context, "Confirm Your Action", "Do you want to logout now?", _authService.signOut)
                    //onTap(context, 0),
            )
          ],
        ),
      ),
    );
  }
}