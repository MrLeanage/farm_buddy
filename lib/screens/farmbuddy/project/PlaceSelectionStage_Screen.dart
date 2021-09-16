import 'package:farm_buddy/model/common/Question.dart';
import 'package:farm_buddy/model/plant/OnGoingProject.dart';
import 'package:farm_buddy/services/api_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/toastMessage.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'ViewPlantingProject_Screen.dart';

class PlaceSelectionStage extends StatefulWidget {
  String _projectID;

  PlaceSelectionStage(this._projectID);

  @override
  _PlaceSelectionStageState createState() => _PlaceSelectionStageState(this._projectID);
}

class _PlaceSelectionStageState extends State<PlaceSelectionStage> {
  bool isLoading = true;
  String _projectID;

  bool isProjectAdded = true;

  proceedToStepTwo(String projectID) async {
    setState(() => isLoading = true);
    APIService apiService = new APIService();
    if(await apiService.requestToProceedToStepTwo(_projectID)){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return ViewPlantingProject(_projectID);
      }));
    }else{
      ToastMessage.showSuccessToast("Error Occurred While Completing the task. \nTry Again!");
    }
  }

  _PlaceSelectionStageState(this._projectID);

  late List<Question> questionList = [];
  late OngoingProject ongoingProject;

  fetchSpecificOngoingProjectData() async {
    APIService apiService = new APIService();
    ongoingProject = await apiService.fetchSpecificOngoingProject(_projectID);
    setState(() => isLoading = false);
    questionList = ongoingProject.plantStage.growthQuestionList;
    print("Question : "+(ongoingProject.plantStage.growthQuestionList[0].question).toString());
    print("Length :"+(ongoingProject.plantStage.stageName));
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
    return  isLoading? Center(child: CircularProgressIndicator(color: COLOR_GREEN)) : Container(


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
                          width: size.width*0.9,
                          height: size.height*0.07,
                          decoration: BoxDecoration(
                            // color: COLOR_BROWN,

                            gradient: LinearGradient(
                                colors: [
                                  COLOR_GREEN,
                                  COLOR_YELLOW
                                ],
                                begin: const FractionalOffset(0.2, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                            borderRadius: BorderRadius.circular(size.width *0.1/8),
                            // image: DecorationImage(
                            //     fit: BoxFit.cover,
                            //     image: NetworkImage(shopList[index].cropImageURL)
                            // )
                          ),
                          child: Row(
                            children: [
                              addHorizontalSpace(size.width*0.02),
                              Container(

                                child:FittedBox(
                                    child: Icon(Icons.work, color: COLOR_GREEN, size: size.width*0.07,),
                                    fit: BoxFit.none
                                ),
                                width: size.width *0.08,
                                height: size.height*0.05,

                                decoration: BoxDecoration(
                                  // color: COLOR_BROWN,
                                  color: COLOR_WHITE,

                                  borderRadius: BorderRadius.circular(size.width *0.1/6),
                                  // image: DecorationImage(
                                  //     fit: BoxFit.cover,
                                  //     image: NetworkImage(shopList[index].cropImageURL)
                                  // )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  maxLines: null,
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    text: "Step 2 : Set Up your Places",

                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.06, color: COLOR_WHITE),
                                  ),

                                ),
                              ),
                            ],
                          ),

                        ),

                        addVerticalSpace(size.height*0.09),
                        Container(
                          width: size.width*0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              maxLines: null,
                              textAlign: TextAlign.justify,
                              text: TextSpan(

                                  text: 'What\'s Next? \n',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.06,  color: COLOR_GREEN),
                                  children: [
                                    TextSpan(text: "\t\t"+"You need to set up a place for planting of your crop. Find the following prerequisites and follow the instructions given to plant the selected crop in selected Place",
                                        style:  TextStyle(fontWeight: FontWeight.normal, fontSize: size.width*0.045,color: COLOR_BLACK)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ),
                        addVerticalSpace(size.height*0.09),
                        Container(
                          width: size.width*0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: RichText(
                              maxLines: null,
                              textAlign: TextAlign.justify,
                              text: TextSpan(

                                  text: 'Prerequisites \n',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.06,  color: COLOR_GREEN),
                                  children: [
                                    TextSpan(text: "\t\t"+"",
                                        style:  TextStyle(fontWeight: FontWeight.normal, fontSize: size.width*0.045,color: COLOR_BLACK)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width*0.9,
                          child:  Container(
                            width: size.width*0.9,
                            height: size.height*0.5,
                            child: ListView.builder(

                              itemCount: ongoingProject.initialization.prerequisite.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    tileColor: Colors.grey[300],
                                    dense:true,
                                    contentPadding: EdgeInsets.symmetric(vertical: size.width*0.01, horizontal:
                                    size.height*0.01),
                                    title: Row(
                                      children: [


                                        SizedBox(width: size.width*0.05),
                                        Column(

                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width*0.58,
                                              child: RichText(
                                                maxLines: null,
                                                textAlign: TextAlign.justify,
                                                text: TextSpan(
                                                    text: (index +1).toString() +". "+ ongoingProject.initialization.prerequisite[index]+'\n',
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),

                                                ),
                                              ),
                                            ),
                                            // Text(
                                            //
                                            //   style: TextStyle(
                                            //       fontSize: size.width*0.04,
                                            //       fontWeight: FontWeight.bold
                                            //   ),
                                            // ),
                                            // Text(
                                            //   questionList[index].cropName,
                                            //   style: TextStyle(
                                            //       fontSize:size.width*0.04,
                                            //       fontWeight: FontWeight.bold,
                                            //       color: COLOR_GREEN
                                            //   ),
                                            // )
                                          ],
                                        ),

                                      ],
                                    ),
                                    onTap: () async{
                                      Alert(
                                          context: context,
                                          title: "What's Next?",
                                          desc: questionList[index].question.toString(),
                                          style: AlertStyle(
                                            titleStyle: TextStyle(color: COLOR_GREEN, fontSize: size.width*0.05),
                                            descStyle: TextStyle(color: COLOR_BLACK, fontSize:  size.width*0.04),

                                          ),
                                          content: Column(
                                            children: <Widget>[



                                            ],
                                          ),
                                          buttons: [
                                            DialogButton(
                                              // onPressed: () => Navigator.pop(context),
                                              onPressed: () =>{
                                                Navigator.pop(context),
                                                isLoading? CircularProgressIndicator() : proceedToStepTwo(ongoingProject.projectID),
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
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        addVerticalSpace(size.height*0.09),
                        Container(
                          width: size.width*0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: RichText(
                              maxLines: null,
                              text: TextSpan(

                                  text: 'Place Finding and Seeding Methodology \n',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.06,  color: COLOR_GREEN),

                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width*0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: RichText(
                              maxLines: null,
                              textAlign: TextAlign.justify,
                              text: TextSpan(

                                  children: [
                                    TextSpan(text: "\t\t"+"Follow the following guidelines and methodologies to select a proper face for your crop and do the seeding of your purchased seeds. Make sure you have followed and satisfied all the requirements and methodology before proceeding to next step",
                                        style:  TextStyle(fontWeight: FontWeight.normal, fontSize: size.width*0.045,color: COLOR_BLACK)
                                    ),


                                  ]
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width*0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: RichText(
                              maxLines: null,
                              textAlign: TextAlign.justify,
                              text: TextSpan(

                                  children: [
                                    TextSpan(text: "You are about to follow "+ ongoingProject.initialization.placeName + " for your crop. Please follow following steps",
                                        style:  TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045,color: COLOR_BLACK)
                                    ),


                                  ]
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width*0.9,
                          child:  Container(
                            width: size.width*0.9,
                            height: size.height*0.5,
                            child: ListView.builder(

                              itemCount: ongoingProject.initialization.methodology.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    tileColor: Colors.grey[300],
                                    dense:true,
                                    contentPadding: EdgeInsets.symmetric(vertical: size.width*0.01, horizontal:
                                    size.height*0.01),
                                    title: Row(
                                      children: [

                                        Container(
                                          child:FittedBox(
                                              child: Icon(Icons.follow_the_signs, color: COLOR_WHITE, size: size.width*0.09,),
                                              fit: BoxFit.none
                                          ),
                                          width: size.width *0.15,
                                          height: size.height*0.09,

                                          decoration: BoxDecoration(
                                            // color: COLOR_BROWN,

                                            gradient: LinearGradient(
                                                colors: [
                                                  COLOR_GREEN,
                                                  COLOR_YELLOW
                                                ],
                                                begin: const FractionalOffset(0.2, 0.0),
                                                end: const FractionalOffset(1.0, 0.0),
                                                stops: [0.0, 1.0],
                                                tileMode: TileMode.clamp),
                                            borderRadius: BorderRadius.circular(size.width *0.1/4),
                                            // image: DecorationImage(
                                            //     fit: BoxFit.cover,
                                            //     image: NetworkImage(shopList[index].cropImageURL)
                                            // )
                                          ),
                                        ),
                                        SizedBox(width: size.width*0.05),
                                        Column(

                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width*0.58,
                                              child: RichText(
                                                maxLines: null,
                                                textAlign: TextAlign.justify,
                                                text: TextSpan(
                                                  text: "Step "+(index +1).toString() +" : "+ ongoingProject.initialization.methodology[index]+'\n',
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),

                                                ),
                                              ),
                                            ),
                                            // Text(
                                            //
                                            //   style: TextStyle(
                                            //       fontSize: size.width*0.04,
                                            //       fontWeight: FontWeight.bold
                                            //   ),
                                            // ),
                                            // Text(
                                            //   questionList[index].cropName,
                                            //   style: TextStyle(
                                            //       fontSize:size.width*0.04,
                                            //       fontWeight: FontWeight.bold,
                                            //       color: COLOR_GREEN
                                            //   ),
                                            // )
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        addVerticalSpace(size.height*0.09),
                        Container(
                          width: size.width*0.9,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              maxLines: null,
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                  text: 'Are you ready to proceed to next Step?\n',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.05, color: COLOR_BLACK),
                                  children: [
                                    TextSpan(text: "\t\tYou are about to start your project now!. Make sure again you followed above requisites and mythologies to proceed. Once you Start project, plant will be monitored through this application and guidelines to follow will be giving to you.",
                                        style:  TextStyle(fontWeight: FontWeight.normal)
                                    )
                                  ]
                              ),
                            ),
                          ),
                        ),
                        addVerticalSpace(size.height*0.09),
                        Container(
                          width: size.width*0.9,
                          height: size.height*0.065,
                          decoration: BoxDecoration(
                            // color: COLOR_BROWN,

                            gradient: LinearGradient(
                                colors: [
                                  COLOR_GREEN,
                                  COLOR_YELLOW
                                ],
                                begin: const FractionalOffset(0.2, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                            borderRadius: BorderRadius.circular(size.width *0.1/8),
                            // image: DecorationImage(
                            //     fit: BoxFit.cover,
                            //     image: NetworkImage(shopList[index].cropImageURL)
                            // )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              maxLines: null,
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text: "Project Status",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: COLOR_WHITE, ),

                              ),
                            ),
                          ),
                        ),

                        addVerticalSpace(size.height*0.09),
                        Container(
                          width: size.width,
                          height: size.height*0.05,
                          child: Text(
                            "Project Completion Status : "+(ongoingProject.completionPercentage).toString()+"%",
                            style: TextStyle(fontSize: 20, color : COLOR_GREEN, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: size.height*0.05,),
                        Container(
                          width: size.width,
                          height: size.height*0.02,
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(COLOR_GREEN),
                            backgroundColor: COLOR_LIGHT_GREY,
                            value:ongoingProject.completionPercentage /100,
                          ),
                        ),
                        Container(
                          width: size.width*0.9,
                          child: Row(
                            children: [
                              Container(
                                width: size.width *0.1,
                                height: size.height*0.065,
                                child:FittedBox(
                                    child: Icon(Icons.eco, color: COLOR_WHITE, size: size.width*0.08,),
                                    fit: BoxFit.none
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      COLOR_GREEN,
                                      COLOR_YELLOW,
                                    ],
                                  ),

                                  borderRadius: BorderRadius.circular(size.width *0.1/4),
                                  // image: DecorationImage(
                                  //     fit: BoxFit.cover,
                                  //     image: NetworkImage(shopList[index].cropImageURL)
                                  // )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                            ],
                          ),
                        ),
                        addVerticalSpace(size.height*0.02),
                        Container(
                          width: size.width*0.9,
                          child: Row(
                            children: [
                              Container(
                                width: size.width *0.1,
                                height: size.height*0.065,
                                child:FittedBox(
                                    child: Icon(Icons.date_range, color: COLOR_WHITE, size: size.width*0.08,),
                                    fit: BoxFit.none
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      COLOR_GREEN,
                                      COLOR_YELLOW,
                                    ],
                                  ),

                                  borderRadius: BorderRadius.circular(size.width *0.1/4),
                                  // image: DecorationImage(
                                  //     fit: BoxFit.cover,
                                  //     image: NetworkImage(shopList[index].cropImageURL)
                                  // )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RichText(
                                  maxLines: null,
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(

                                      text: 'Project Start Date : \n',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                                      children: [
                                        TextSpan(text: "\t\t"+ongoingProject.projectStartDate,
                                            style:  TextStyle(fontWeight: FontWeight.normal)
                                        )
                                      ]
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        addVerticalSpace(size.height*0.02),
                        Container(
                          width: size.width*0.9,
                          decoration: BoxDecoration(
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: size.width *0.1,
                                height: size.height*0.065,
                                child:FittedBox(
                                    child: Icon(Icons.update, color: COLOR_WHITE, size: size.width*0.08,),
                                    fit: BoxFit.none
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      COLOR_GREEN,
                                      COLOR_YELLOW,
                                    ],
                                  ),

                                  borderRadius: BorderRadius.circular(size.width *0.1/4),
                                  // image: DecorationImage(
                                  //     fit: BoxFit.cover,
                                  //     image: NetworkImage(shopList[index].cropImageURL)
                                  // )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                            ],
                          ),
                        ),
                        MaterialButton(
                          onPressed: () async{
                            Alert(
                                context: context,
                                title: "Confirm Your Action !!",
                                desc: "Have you Complete Place Arrangement? \n"
                                    "You are about to start your project now!. "
                                    "Make sure again you followed above requisites and mythologies to proceed. Once you Start project, "
                                    "plant will be monitored through this application and guidelines to follow will be giving to you.",
                                style: AlertStyle(
                                  titleStyle: TextStyle(color: COLOR_GREEN, fontSize: size.width*0.05),
                                  descStyle: TextStyle(color: COLOR_BLACK, fontSize:  size.width*0.04),

                                ),
                                buttons: [
                                  DialogButton(
                                    // onPressed: () => Navigator.pop(context),
                                    onPressed: () =>{
                                      Navigator.pop(context),
                                      isLoading? CircularProgressIndicator() : proceedToStepTwo(ongoingProject.projectID),
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
                                'Start Project Now',
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