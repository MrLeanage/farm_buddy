
import 'package:farm_buddy/services/authenticate_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import '../utils/custom_widgets/snackBar_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/border_box.dart';
import 'package:flutter/material.dart';


class HomeScreen1 extends StatelessWidget  {
  static const routeName = '/home';
  final AuthService _authService = AuthService();
  final double padding = 25;
  final sidePadding = EdgeInsets.symmetric(horizontal: 25);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //
        //   title: Text('Farm Buddy'),
        //
        //   actions: <Widget>[
        //
        //     TextButton(
        //         onPressed: () async{
        //           await _authService.signOut();
        //           ///Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);
        //         },
        //         child: Row(
        //           children: <Widget>[
        //             Text(
        //                 'Logout',
        //                 style: TextStyle(color: Colors.white)
        //             ),
        //             Icon(
        //               Icons.person,
        //             )
        //           ],
        //         )
        //     )
        //   ],
        // ),
        body: Container(
          width: size.width,
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              addVerticalSpace(padding),
              Padding(
                padding: sidePadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BorderBox(
                        padding: EdgeInsets.all(0),
                        width: 50,
                        height: 50,
                        child: Icon(Icons.menu, color: COLOR_BLACK)),
                    BorderBox(
                        padding: EdgeInsets.all(0),
                        width: 50,
                        height: 50,
                        child: Icon(Icons.settings, color: COLOR_BLACK))
                  ],
                ),
              ),
              addVerticalSpace(padding),
              Padding(
                padding: sidePadding,
                child: Text("My Farming Projects", style: themeData.textTheme.headline3,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
