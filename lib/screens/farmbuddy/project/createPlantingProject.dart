import 'package:farm_buddy/screens/authenticate/login_screen.dart';
import 'package:farm_buddy/services/authenticate_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'package:flutter/material.dart';

class CreatePlantingProject extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _CreatePlantingProjectState createState() => _CreatePlantingProjectState();
}

class _CreatePlantingProjectState extends State<CreatePlantingProject> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthService _authService = AuthService();
  bool loading = false;

  //form field states
  String name = '';
  String password = '';
  String registerError = '';

  TextEditingController _passwordController = new TextEditingController();
  void _submit() async{
    setState(() => loading = true) ;
    if(_formKey.currentState!.validate()){
      dynamic result = await _authService.registerWithEmailAndPassword(name, password);
      if(result.toString().contains('already in use by another account')){
        setState(() => registerError = 'The email address is already in use by another account');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(true),

        ),
        title: Text("Create Planting Project"),
      ),
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
                        //Email Field
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Planting Project Name'),
                          keyboardType: TextInputType.text,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Project Name Needed!';
                            }
                            return null;
                          },
                          onChanged: (value){
                            setState(() => name = value);
                          },
                        ),
                        // password Field

                        //Confirm Password


                        ElevatedButton(

                          child: Text(
                            'Create Project',
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
