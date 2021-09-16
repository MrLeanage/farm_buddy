
import 'package:farm_buddy/model/common/Question.dart';
import 'package:farm_buddy/model/plant/OnGoingProject.dart';
import 'package:farm_buddy/screens/farmbuddy/app_home/AppBase_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/project/PlaceSelectionStage_Screen.dart';
import 'package:farm_buddy/screens/farmbuddy/project/ViewPlantingProject_Screen.dart';
import 'package:farm_buddy/services/api_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/toastMessage.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PurchaseStage extends StatefulWidget {
  String _projectID;

  PurchaseStage(this._projectID);

  @override
  _PurchaseStageState createState() => _PurchaseStageState(this._projectID);
}

class _PurchaseStageState extends State<PurchaseStage> {
  bool isLoading = true;
  String _projectID;


  proceedToStepOne(String projectID) async {
    setState(() => isLoading = true);
    APIService apiService = new APIService();
    if(await apiService.requestToProceedToStepOne(_projectID)){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return ViewPlantingProject(_projectID);
      }));
    }else{
      ToastMessage.showSuccessToast("Error Occurred While Completing the task. \nTry Again!");
    }
  }

  _PurchaseStageState(this._projectID);

  late List<Question> questionList = [];
  late OngoingProject ongoingProject;

  fetchSpecificOngoingProjectData() async {
    APIService apiService = new APIService();
    ongoingProject = await apiService.fetchSpecificOngoingProject(_projectID);
    setState(() => isLoading = false);
    questionList = ongoingProject.plantStage.growthQuestionList;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchSpecificOngoingProjectData();

  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return isLoading? Center(child: CircularProgressIndicator(color: COLOR_GREEN)) :Container(


        child: SingleChildScrollView(

          child: Center(
            child: Container(
              child: Stack(

                children: [

                  Padding(
                    padding:  EdgeInsets.all(20),
                    child: Wrap(
                      children: [
                        Container(
                          color: COLOR_GREEN,
                          width: size.width,
                          height: size.height*0.075,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Step 1 : Purchase Your Plant',
                              style: TextStyle(fontSize: 20, color : COLOR_WHITE, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: size.height*0.2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              maxLines: null,
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text: "Now you need to purchase selected crop Seed from verified Vegetable Seed Centers. Once you Purchase selected seeds, Click on proceed to go to Next Step",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),

                              ),
                            ),
                          ),
                        ),

                        MaterialButton(
                          onPressed: () async{
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context){
                                      return HomeScreen(3);
                                    }));
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                          padding: const EdgeInsets.all(4.0),
                          child: Ink(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    COLOR_GREEN,
                                    COLOR_YELLOW
                                  ],
                                  begin: const FractionalOffset(0.2, 0.0),
                                  end: const FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                              borderRadius: BorderRadius.all(Radius.circular(80.0)),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 88.0, minHeight: 50.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'VIEW SHOP INFORMATION',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: COLOR_WHITE,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        ),

                        addVerticalSpace(size.height*0.1),

                        Container(
                          color: COLOR_GREEN,
                          width: size.width,
                          height: size.height*0.075,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Project Status",
                              style: TextStyle(fontSize: 22, color : COLOR_WHITE, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width*0.9,
                          child: RichText(
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                text: 'Project Status : \n',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                                children: [
                                  TextSpan(text: "\t\t"+ ongoingProject.status,
                                      style:  TextStyle(fontWeight: FontWeight.normal)
                                  )
                                ]
                            ),
                          ),
                        ),
                        addVerticalSpace(size.height*0.09),
                        Container(
                          width: size.width*0.9,
                          child: RichText(
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            text: TextSpan(

                                text: 'Project Created Date : \n',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                                children: [
                                  TextSpan(text: "\t\t"+ongoingProject.projectStartDate,
                                      style:  TextStyle(fontWeight: FontWeight.normal)
                                  )
                                ]
                            ),
                          ),
                        ),
                        addVerticalSpace(size.height*0.09),
                        Container(
                          width: size.width*0.9,
                          child: RichText(
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            text: TextSpan(

                                text: 'Project Last Updated Date : \n',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                                children: [
                                  TextSpan(text: "\t\t"+ongoingProject.projectLastUpdateDate,
                                      style:  TextStyle(fontWeight: FontWeight.normal)
                                  )
                                ]
                            ),
                          ),
                        ),
                        addVerticalSpace(size.height*0.1),
                        MaterialButton(
                          onPressed: () async{
                            Alert(
                                context: context,
                                title: "Confirm Your Action",
                                desc: "Have you Purchased Seeds?",
                                style: AlertStyle(
                                  titleStyle: TextStyle(color: COLOR_GREEN, fontSize: size.width*0.05),
                                  descStyle: TextStyle(color: COLOR_BLACK, fontSize:  size.width*0.04),

                                ),
                                buttons: [
                                  DialogButton(
                                    // onPressed: () => Navigator.pop(context),
                                    onPressed: () =>{
                                      Navigator.pop(context),
                                      isLoading? CircularProgressIndicator() : proceedToStepOne(ongoingProject.projectID),
                                    },

                                    child: Text(
                                      "Yes",
                                      style: TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                    color: COLOR_GREEN,
                                    // gradient: LinearGradient(colors: [
                                    //   COLOR_GREEN,
                                    //   COLOR_YELLOW
                                    // ]),
                                  ),
                                  DialogButton(
                                    // onPressed: () => Navigator.pop(context),
                                    onPressed: () =>{
                                      Navigator.pop(context)
                                    },

                                    child: Text(
                                      "No",
                                      style: TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                    color: COLOR_GREY,
                                    // gradient: LinearGradient(colors: [
                                    //   COLOR_GREEN,
                                    //   COLOR_YELLOW
                                    // ]),
                                  )
                                ]).show();

                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                          padding: const EdgeInsets.all(4.0),
                          child: Ink(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    COLOR_GREEN,
                                    COLOR_YELLOW
                                  ],
                                  begin: const FractionalOffset(0.2, 0.0),
                                  end: const FractionalOffset(1.0, 0.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                              borderRadius: BorderRadius.all(Radius.circular(80.0)),
                            ),
                            child: Container(
                              constraints: const BoxConstraints(minWidth: 88.0, minHeight: 50.0), // min sizes for Material buttons
                              alignment: Alignment.center,
                              child: const Text(
                                'Proceed to Step 2',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: COLOR_WHITE,
                                    fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );

  }
}