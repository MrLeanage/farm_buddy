import 'package:farm_buddy/model/common/Question.dart';
import 'package:farm_buddy/model/plant/OnGoingProject.dart';
import 'package:farm_buddy/services/api_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/toastMessage.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProjectTask extends StatefulWidget {
  String _projectID;

  ProjectTask(this._projectID);

  @override
  _ProjectTaskState createState() => _ProjectTaskState(this._projectID);
}

class _ProjectTaskState extends State<ProjectTask> {
  bool isLoading = true;
  String _projectID;

  bool isProjectAdded = true;

  updateQuestion(String questionID) async {
    setState(() => isLoading = true);
    APIService apiService = new APIService();
    if(await apiService.updatingProjectQuestion(_projectID, questionID)){
      fetchSpecificOngoingProjectData();
      setState(() => isLoading = false);
      ToastMessage.showSuccessToast("Task Completed!");
      Navigator.pop(context);
    }else{
      ToastMessage.showSuccessToast("Error Occurred While Completing the task. \nTry Again!");
    }
  }

  _ProjectTaskState(this._projectID);

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
    return Container(


        child: SingleChildScrollView(

          child: Center(
            child: isLoading? CircularProgressIndicator() :Container(
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
                                    child: Icon(Icons.task, color: COLOR_GREEN, size: size.width*0.07,),
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
                                    text: ongoingProject.plantStage.stageName,

                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.06, color: COLOR_WHITE),
                                  ),

                                ),
                              ),
                            ],
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
                                text: ongoingProject.crop.cropNoteMsg+'\n',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),

                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: size.height*0.05,
                          child: Text(
                            "Water Amount to pour today : "+(ongoingProject.plantStage.dailyWater),
                            style: TextStyle(fontSize: 20, color : COLOR_BLACK, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: size.width,
                          height: size.height*0.05,
                          child: Text(
                            "Stage Completion Status : "+(ongoingProject.currentStageCompletionPercentage).toString()+"%",
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
                            value:ongoingProject.currentStageCompletionPercentage /100,
                          ),
                        ),

                        Text(
                          "What's Next? ",
                          textAlign: TextAlign.left,
                          style: TextStyle(

                              fontSize: size.width*0.06,
                              fontWeight: FontWeight.bold,
                              color: COLOR_GREEN
                          ),
                        ),
                        Container(
                          width: size.width*0.9,
                          child:  Container(
                            width: size.width*0.9,
                            height: size.height*0.4,
                            child: ListView.builder(

                              itemCount: questionList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    tileColor: Colors.grey[300],
                                    title: Row(
                                      children: [

                                        Container(
                                          width: size.width *0.15,
                                          height: size.height*0.09,
                                          child:FittedBox(
                                              child: Icon(Icons.question_answer_outlined, color: COLOR_WHITE, size: size.width*0.09,),
                                              fit: BoxFit.none
                                          ),
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
                                        SizedBox(width: size.width*0.05,),
                                        Column(

                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: size.width*0.58,
                                              child: RichText(
                                                maxLines: null,
                                                textAlign: TextAlign.justify,
                                                text: TextSpan(
                                                    text: questionList[index].indexNo.toString()+'\n',
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                                                    children: [
                                                      TextSpan(text: questionList[index].question.toString(),
                                                          style:  TextStyle(fontWeight: FontWeight.normal)
                                                      )
                                                    ]
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
                                            SizedBox(height: size.height*0.01,),
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
                                                updateQuestion(ongoingProject.plantStage.growthQuestionList[index].indexNo),
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
                          child: RichText(
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                text: 'Stage Life Span \n',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                                children: [
                                  TextSpan(text: "\t\tApproximately "+ ongoingProject.plantStage.stageLifeSpan.toString() + " Days",
                                      style:  TextStyle(fontWeight: FontWeight.normal)
                                  )
                                ]
                            ),
                          ),
                        ),
                        // addVerticalSpace(size.height*0.09),
                        // Container(
                        //   width: size.width*0.9,
                        //   child: RichText(
                        //     maxLines: null,
                        //     textAlign: TextAlign.justify,
                        //     text: TextSpan(
                        //         text: 'Stage Start Date: \n',
                        //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                        //         children: [
                        //           TextSpan(text: "\t\t"+ ongoingProject.plantStage.stageStartDate.toString(),
                        //               style:  TextStyle(fontWeight: FontWeight.normal)
                        //           )
                        //         ]
                        //     ),
                        //   ),
                        // ),
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
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  COLOR_GREEN,
                                  COLOR_YELLOW,
                                ],
                              )
                          ),
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(COLOR_GREEN),
                            backgroundColor: COLOR_LIGHT_GREY,
                            value:ongoingProject.completionPercentage /100,
                          ),
                        ),
                        addVerticalSpace(size.height*0.05),
                        Container(
                          height: size.height*0.32,
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
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  width: size.width*0.9,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          COLOR_GREEN,
                                          COLOR_YELLOW,
                                        ],
                                      )
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width *0.1,
                                        height: size.height*0.065,
                                        child:FittedBox(
                                            child: Icon(Icons.eco, color: COLOR_GREEN, size: size.width*0.08,),
                                            fit: BoxFit.none
                                        ),
                                        decoration: BoxDecoration(
                                          color: COLOR_WHITE,

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
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_WHITE),
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
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          COLOR_GREEN,
                                          COLOR_YELLOW,
                                        ],
                                      )
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width *0.1,
                                        height: size.height*0.065,
                                        child:FittedBox(
                                            child: Icon(Icons.date_range, color: COLOR_GREEN, size: size.width*0.08,),
                                            fit: BoxFit.none
                                        ),
                                        decoration: BoxDecoration(
                                          color: COLOR_WHITE,

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
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_WHITE),
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
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          COLOR_GREEN,
                                          COLOR_YELLOW,
                                        ],
                                      )
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: size.width *0.1,
                                        height: size.height*0.065,
                                        child:FittedBox(
                                            child: Icon(Icons.update, color: COLOR_GREEN, size: size.width*0.08,),
                                            fit: BoxFit.none
                                        ),
                                        decoration: BoxDecoration(
                                          color: COLOR_WHITE,

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
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_WHITE),
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
                              ],
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
    // );
  }
}
