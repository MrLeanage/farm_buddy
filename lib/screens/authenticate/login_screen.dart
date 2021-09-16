import 'package:farm_buddy/utils/constants.dart';
import '../../utils/custom_widgets/snackBar_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';

import '../farmbuddy/app_home/AppBase_Screen.dart';
import '../../utils/custom_widgets/loader_widget.dart';
import 'package:farm_buddy/services/authenticate_service.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import '../farmbuddy/app_home/AppBase_Screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthService _authService = AuthService();

  bool loading = false;

  //form field states
  String email = '';
  String password = '';
  String loginError = '';

  void _submit() async{
    print("Email :" + email);
    print("Password :" + password);
    setState(() => loading = true);

    dynamic result = await _authService.signInWithEmailAndPassword(email, password);
    if(result == null){
      setState(() => loading = false);
      setState(() => loginError = 'Please check your Internet Connection');
    }
    if(result.toString().contains('no user record corresponding')){
      setState(() => loading = false);
      setState(() => loginError = 'Invalid Email, Please Sign Up!');
    }
    if(result.toString().contains('password is invalid')){
      setState(() => loading = false);
      setState(() => loginError = 'Invalid Password!');
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return loading ? Loader() : Scaffold(

      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient:LinearGradient(
                  colors: [
                    COLOR_GREEN,
                    COLOR_YELLOW
                  ],
                  begin: const FractionalOffset(0.4, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          Center(
            child: Card(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Container(
                height: 400,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child:
                    Column(
                      children: <Widget>[
                        Image.asset('assets/logo-cover.png'),
                        //Email Field
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),

                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value!.isEmpty || !value.contains('@')){
                              return 'Invalid Email';
                            }
                            return null;
                          },
                          onChanged: (value){
                            setState(() => email = value);
                          },
                        ),
                        // password Field
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value){
                            if(value!.isEmpty || value.length <= 5){
                              return 'Invalid Password';
                            }
                            return null;
                          },
                          onChanged: (value){
                            setState(() => password = value);
                          },
                        ),

                        Text(
                          loginError,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                       SizedBox(
                         height: 20,
                       ),
                       ElevatedButton(

                         child: Text(
                           'Login',
                         ),
                         style: ElevatedButton.styleFrom(
                          primary: COLOR_YELLOW,
                           minimumSize: Size(size.width, size.height*0.05),
                           textStyle: TextStyle(
                             color: COLOR_BLACK
                           )
                         ),
                         onPressed: () async{
                           if(_formKey.currentState!.validate()){
                             _submit();
                           }

                         },

                       ),
                        Row(
                          children: [
                            Text(
                              'New User? Sign Up Now'
                            ),
                            addHorizontalSpace(10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: COLOR_GREEN
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                      'Signup',
                                      style: TextStyle(
                                        color: Colors.white,

                                      )
                                  ),
                                  Icon(
                                    Icons.person,
                                  )
                                ],
                              ),
                              onPressed: () async{
                                Navigator.of(context).pushReplacementNamed(SignupScreen.routeName);

                              },

                            )
                          ],
                        ),


                      ],
                    ),
                  ),
                ),

              ),
            ),
          )
        ],
      ),
    );
  }
}
