import 'dart:ui';

import 'package:farm_buddy/model/plant/Project.dart';
import 'package:farm_buddy/screens/farmbuddy/project/ViewPlantingProject_Screen.dart';
import 'package:farm_buddy/services/api_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/appBar.dart';
import 'package:farm_buddy/utils/custom_widgets/pageHeading_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';

import 'CreateProjectStepOne_Screen.dart';

class ProjectScreen extends StatefulWidget {
  static const routeName = '/project';
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> with SingleTickerProviderStateMixin {

  bool isLoading = true;
  late List<Project> projectList = [];

  var onGoingProjects;


  fetchOnGoingProjects() async {
    print("Init Called ");
    APIService apiService = new APIService();
     projectList = await apiService.fetchOnGoingProjectList();

    setState(() => isLoading = false);

  }

  List<Widget> tabList = [
      Tab(
        text: "Planting Projects",
      )
  ];
  late TabController _tabController;
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: tabList.length, vsync:  this);
    _tabController.addListener(() {
      print("Selected Index " + _tabController.index.toString());
    });
    this.fetchOnGoingProjects();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBar(),
      backgroundColor: COLOR_BACKGROUND,

      body: Column(
        children: [
          customAppBar(size.height, size.width, _scaffoldKey),
          PageHeadingWidget("MY FARMING PROJECTS",Icons.workspaces_filled, size.height, size.width),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(

              height: size.height*0.68,
              width: size.width * 0.9,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * 0.05),
                color: COLOR_WHITE
              ),
              child: Stack(
                children: [

                  Column(
                    children: [
                      Center(
                        child: Container(
                          width: size.width*0.9,
                          height: size.height*0.68,
                          child: Center(
                            child: isLoading?
                            Center(child: CircularProgressIndicator(color: COLOR_GREEN)) :Container(
                              color: COLOR_WHITE,
                              width: size.width*0.9,
                              height: size.height*0.8,
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  return fetchOnGoingProjects();
                                },
                                child: ListView.builder(
                                  itemCount: projectList.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      shadowColor: COLOR_GREY,
                                      child: ListTile(

                                        dense:true,
                                        contentPadding: EdgeInsets.symmetric(vertical: size.height*0.02, horizontal:
                                        16.0),
                                        tileColor: Colors.grey[300],
                                        title: Column(
                                          children: [
                                            Row(
                                              children: [

                                                Column(

                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: size.width*0.8,
                                                      decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            begin: Alignment.topLeft,
                                                            end: Alignment.bottomRight,
                                                            colors: [
                                                              COLOR_GREEN,
                                                              COLOR_YELLOW,
                                                            ],
                                                          ),
                                                          borderRadius: BorderRadius.circular(size.width *0.1/7),
                                                      ),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: RichText(
                                                          maxLines: null,
                                                          textAlign: TextAlign.justify,
                                                          text: TextSpan(
                                                              text: projectList[index].projectName.toString()+'\n',
                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.05, color: COLOR_WHITE),
                                                              children: [
                                                                TextSpan(text:  projectList[index].cropName.toString(),
                                                                    style:  TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.035, color: COLOR_WHITE)
                                                                )
                                                              ]
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    // Text(
                                                    //   projectList[index].projectName,
                                                    //   style: TextStyle(
                                                    //       fontSize: size.width*0.04,
                                                    //       fontWeight: FontWeight.bold
                                                    //   ),
                                                    // ),
                                                    // SizedBox(height: size.height*0.01,),
                                                    // Text(
                                                    //   projectList[index].cropName,
                                                    //   style: TextStyle(
                                                    //       fontSize:size.width*0.04,
                                                    //       fontWeight: FontWeight.bold,
                                                    //       color: COLOR_GREEN
                                                    //   ),
                                                    // )
                                                    SizedBox(height: size.height*0.01,)
                                                  ],
                                                ),

                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: size.width *0.15,
                                                  height: size.height*0.09,
                                                  decoration: BoxDecoration(
                                                      color: COLOR_GREEN,
                                                      borderRadius: BorderRadius.circular(size.width *0.1/4),
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(projectList[index].cropImageURL)
                                                      )

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
                                                            text: projectList[index].status + " - " +projectList[index].currentStage+'\n',
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.04, color: COLOR_BLACK),
                                                            children: [
                                                              TextSpan(text:  projectList[index].cropName.toString(),
                                                                  style:  TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.035)
                                                              )
                                                            ]
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: size.height*0.01,),
                                                    Row(
                                                      children: [

                                                        Container(
                                                          width: size.width*0.45,
                                                          height: size.height*0.015,
                                                          child: LinearProgressIndicator(
                                                            valueColor: AlwaysStoppedAnimation<Color>(COLOR_GREEN),
                                                            backgroundColor: COLOR_LIGHT_GREY,
                                                            value:projectList[index].completionPercentage /100,
                                                          ),
                                                        ),
                                                        SizedBox(width: size.width*0.01,),
                                                        Text(
                                                          projectList[index].completionPercentage.toString() + "%",
                                                          style: TextStyle(
                                                              fontSize: size.width*0.04,
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // Text(
                                                    //   projectList[index].projectName,
                                                    //   style: TextStyle(
                                                    //       fontSize: size.width*0.04,
                                                    //       fontWeight: FontWeight.bold
                                                    //   ),
                                                    // ),
                                                    // SizedBox(height: size.height*0.01,),
                                                    // Text(
                                                    //   projectList[index].cropName,
                                                    //   style: TextStyle(
                                                    //       fontSize:size.width*0.04,
                                                    //       fontWeight: FontWeight.bold,
                                                    //       color: COLOR_GREEN
                                                    //   ),
                                                    // )
                                                    SizedBox(height: size.height*0.01,)
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ],
                                        ),
                                        onTap: (){
                                          debugPrint("List Tile Tapped");
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                           return ViewPlantingProject(projectList[index].projectID);
                                          }));
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("clicked Add");
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return CreatePlantingProjectStepOne();
          }));
          // Add your onPressed code here!
        },
        child: const Icon(Icons.add),
        backgroundColor: COLOR_LIGHT_GREEN,
      ),
    );
  }
}

