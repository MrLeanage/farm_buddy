import 'dart:ui';

import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/appBar.dart';
import 'package:farm_buddy/utils/custom_widgets/pageHeading_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';

import '../../../trash/CreateProjectStep_Screen.dart';
class Project extends StatefulWidget {
  @override
  _ProjectState createState() => _ProjectState();
}

class _ProjectState extends State<Project> with SingleTickerProviderStateMixin {

  int _selectedTab = 0;

  List<Widget> tabList = [
      Tab(
        text: "Planting Projects",
      )
  ];
  List projectList = [
    "Tomato Bed 1",
    "Chili Bed 1",
    "Tomato Bed 2",
    "Chili Bed 2",
    "Tomato Bed 3",
    "Chili Bed 3",
    "Tomato Bed 4",
    "Chili Bed 4",
    "Tomato Bed 5",
    "Chili Bed 5",
    "Tomato Bed 6",
    "Chili Bed 6",
    "Tomato Bed 7",
    "Chili Bed 7",
    "Tomato Bed 8",
    "Chili Bed 8",
  ];
  late TabController _tabController;
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: tabList.length, vsync:  this);
    _tabController.addListener(() {
      print("Selected Index " + _tabController.index.toString());
    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = window.physicalSize.width;
    final double screenHeight = window.physicalSize.height;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBar(),
      backgroundColor: COLOR_BACKGROUND,

      body: Column(
        children: [
          customAppBar(screenHeight, screenWidth, _scaffoldKey),
          PageHeadingWidget("MY FARMING PROJECTS",Icons.workspaces_filled, screenHeight, screenWidth),
          Container(
            height: screenHeight*0.18,
            width: screenWidth * 0.27,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenWidth * 0.01),
            ),
            child: DefaultTabController(

                length: tabList.length,
                child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.009),
                      child: AppBar(

                        backgroundColor: COLOR_WHITE,
                        elevation: 0,
                        flexibleSpace: Column(
                          children: [
                            TabBar(
                                unselectedLabelColor: COLOR_GREEN,
                                isScrollable: true,
                                indicatorWeight: 0.01,
                                labelColor: COLOR_WHITE,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: BoxDecoration(
                                //borderRadius: BorderRadius.circular(50),
                                color: COLOR_GREEN),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22

                                ),

                                unselectedLabelStyle: TextStyle(

                                ),
                                tabs: tabList,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  body: TabBarView(
                    //controller: _tabController,
                    children: [
                      Container(
                        height: screenHeight * 0.05,
                       child: ListView.builder(
                         itemCount: projectList.length,
                         itemBuilder: (context, index){
                           return Card(
                             child: ListTile(
                               title:Text(
                                   projectList[index],
                               ),
                               subtitle: Text('Title 2'),
                               trailing: Icon(Icons.library_add),
                               onTap: (){
                                 debugPrint("List Tile Tapped");
                                 // Navigator.push(context, MaterialPageRoute(builder: (context){
                                 //   return ViewPlantingProject();
                                 // }));
                               },
                             ),
                             //child: PageHeadingWidget(projectList[index], Icons.library_add, screenHeight, screenWidth)
                           );
                         }
                       ),
                      ),
                      // Container(
                      //   height: screenHeight * 0.1,
                      //   child: Center(
                      //     child: Text(
                      //       "On Going Fertilizer Projects",
                      //       style: TextStyle(
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.bold
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      debugPrint("Screeen width :"+screenHeight.toString());
                      debugPrint("Screeen width :"+screenWidth.toString());
                      print("clicked Add");
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CreatePlantingProjectStepOne();
                      }));
                      // Add your onPressed code here!
                    },
                    child: const Icon(Icons.add),
                    backgroundColor: COLOR_LIGHT_GREEN,
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}

