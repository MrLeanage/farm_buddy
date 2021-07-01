import 'package:farm_buddy/services/auth.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthService _authService = AuthService();
  bool loading = false;

  //form field states
  String email = '';
  String password = '';
  String registerError = '';

  TextEditingController _passwordController = new TextEditingController();
  void _submit() async{
    setState(() => loading = true) ;
    if(_formKey.currentState!.validate()){
      dynamic result = await _authService.registerWithEmailAndPassword(email, password);
      if(result.toString().contains('already in use by another account')){
        setState(() => registerError = 'The email address is already in use by another account');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: COLOR_GREEN
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              ),
              child: Container(
                height: size.height*0.72,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/logo-cover.png'),
                        //Email Field
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
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
                          controller: _passwordController,
                          validator: (value){
                            if(value!.isEmpty || value.length <= 5){
                              return 'Invalid Password';
                            }
                            return null;
                          },
                        ),
                        //Confirm Password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: (value){
                            if(value!.isEmpty || value != _passwordController.text){
                              return 'Invalid Password';
                            }
                            return null;
                          },
                          onChanged: (value){
                            setState(() => password = value);
                          },
                        ),
                        SizedBox(height: 12.0,),
                        Text(
                          registerError,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(

                          child: Text(
                            'Sign Up',
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
                                'Already Signed Up? Click'
                            ),
                            addHorizontalSpace(20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: COLOR_GREEN
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                      'Login',
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
                                Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);

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
