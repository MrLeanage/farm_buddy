
import 'package:farm_buddy/screens/farmbuddy/app_home/AppBase_Screen.dart';
import 'package:farm_buddy/services/api_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'package:flutter/material.dart';


class CreatePlantingProjectStepOne extends StatefulWidget {

  @override
  _CreatePlantingProjectStepOneState createState() => _CreatePlantingProjectStepOneState();
}

class _CreatePlantingProjectStepOneState extends State<CreatePlantingProjectStepOne> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final APIService _apiService = new APIService();
  bool loading = false;

  //form field states
  String state = '';
  String searchError = '';
  String dropdownValue = 'Western';

  TextEditingController _passwordController = new TextEditingController();
  void _submit() async{
    setState(() => loading = true) ;
    if(_formKey.currentState!.validate()){
      dynamic result = await _apiService.getViableCropData(state);
      for(var data in result){
        print('Response from API at Search:' +data.name);
      }

      if(result.status){
        setState(() => searchError = 'Error Occurred while retrieving Viable Crop Data');
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
                width: size.width *0.9,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Image.asset('assets/logo-cover.png'),
                        //State Field
                        Text(
                          'Start New Planting Project',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            fontSize: 25
                          ),
                        ),
                        Text(
                          'Step One',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
                        addVerticalSpace(size.height * 0.1),

                        Row(
                          children: [
                            Icon(Icons.gps_fixed),
                            addHorizontalSpace(size.width*0.03),
                            Text(
                              'Select Province :',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                            addHorizontalSpace(size.width*0.04),
                            Container(
                              width: size.width*0.3,
                              child: DropdownButton<String>(

                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                                iconSize: 20,
                                elevation: 15,
                                style: const TextStyle(
                                    color: COLOR_GREEN,
                                  fontWeight: FontWeight.bold

                                ),
                                underline: Container(
                                  height: 2,
                                  color: COLOR_GREEN,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: <String>['Western', 'Southern', 'Central', 'Eastern', 'Northern', 'North-Western', 'North-Central', 'Uva', 'Sabaragamuwa']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                // Month Field
                              ),
                            ),
                          ],
                        ),
                    
                        //Confirm Password


                        ElevatedButton(

                          child: Text(
                            'Next',
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
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return HomeScreen(1);
                              }));
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
