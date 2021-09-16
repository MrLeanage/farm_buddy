import 'package:farm_buddy/model/plant/OnGoingProject.dart';
import 'package:farm_buddy/model/plant/Project.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'package:flutter/material.dart';

class ProjectCropInfo extends StatefulWidget {
  OngoingProject _ongoingProject;

  ProjectCropInfo(this._ongoingProject);

  @override
  _ProjectCropInfoState createState() => _ProjectCropInfoState(this._ongoingProject);
}

class _ProjectCropInfoState extends State<ProjectCropInfo> {
  OngoingProject _ongoingProject;
  _ProjectCropInfoState(this._ongoingProject);
  @override
  Widget build(BuildContext context) {
    String cropPreNote = "";


    final Size size = MediaQuery.of(context).size;
    return Container(


        child: SingleChildScrollView(

          child: Center(
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
                                  child: Icon(Icons.eco, color: COLOR_GREEN, size: size.width*0.07,),
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
                                  text: _ongoingProject.crop.name,

                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.06, color: COLOR_WHITE),
                                ),

                              ),
                            ),
                          ],
                        ),

                      ),

                      addVerticalSpace(size.height*0.09),
                      Container(

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              text: _ongoingProject.crop.description,

                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: COLOR_BLACK),
                            ),

                          ),
                        ),

                      ),
                      Container(
                        width: size.width*0.9,
                        height: size.height*0.06,
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
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text:"Place Selection Type",

                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045, color: COLOR_WHITE),
                            ),

                          ),
                        ),

                      ),
                      Container(
                        width: size.width*0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK, ),
                                children: [
                                  TextSpan(text: "\t\t"+_ongoingProject.initialization.placeName,
                                      style:  TextStyle(fontWeight: FontWeight.bold)
                                  )
                                ]
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpace(size.height*0.09),
                      Container(
                        width: size.width*0.9,
                        height: size.height*0.06,
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
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text:"Preferred Daily Water Amount",

                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045, color: COLOR_WHITE),
                            ),

                          ),
                        ),

                      ),
                      Container(
                        width: size.width*0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            text: TextSpan(

                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                                children: [
                                  TextSpan(text: "\t\t"+_ongoingProject.plantStage.stageWater + "( for current "+ _ongoingProject.currentStage+ ")",
                                      style:  TextStyle(fontWeight: FontWeight.bold)
                                  )
                                ]
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpace(size.height*0.09),
                      Container(
                        width: size.width*0.9,
                        height: size.height*0.06,
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
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text:"Life Span",

                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045, color: COLOR_WHITE),
                            ),

                          ),
                        ),

                      ),

                      Container(
                        width: size.width*0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                                children: [
                                  TextSpan(text: "\t\t"+_ongoingProject.crop.lifeSpan + " Days from the day of project Start",
                                      style:  TextStyle(fontWeight: FontWeight.bold)
                                  )
                                ]
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpace(size.height*0.09),
                      Container(
                        width: size.width*0.9,
                        height: size.height*0.06,
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
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              text:"About Coming Days..",

                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045, color: COLOR_WHITE),
                            ),

                          ),
                        ),

                      ),
                      Container(
                        width: size.width*0.9,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            maxLines: null,
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                                children: [
                                  TextSpan(text: "\t\t"+cropPreNote+_ongoingProject.crop.cropNoteMsg,
                                      style:  TextStyle(fontWeight: FontWeight.bold)
                                  )
                                ]
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpace(size.height*0.1)

                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}