
import 'package:farm_buddy/model/plant/OnGoingProject.dart';
import 'package:farm_buddy/model/plant/Project.dart';
import 'package:farm_buddy/services/api_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/loader_widget.dart';
import 'package:flutter/material.dart';

import 'PlaceSelectionStage_Screen.dart';
import 'ProjectCropInfo_Screen.dart';
import 'ProjectTask_Screen.dart';
import 'PurchaseStage_Screen.dart';

class ViewPlantingProject extends StatefulWidget {
  String _projectID;


  ViewPlantingProject(this._projectID);

  @override
  _ViewPlantingProjectState createState() => _ViewPlantingProjectState(this._projectID);
}

class _ViewPlantingProjectState extends State<ViewPlantingProject> {
  String _projectID;
  _ViewPlantingProjectState(this._projectID);

  late OngoingProject ongoingProject;
  bool isLoading = true;

  fetchSpecificOngoingProjectData() async {
    APIService apiService = new APIService();
    ongoingProject = await apiService.fetchSpecificOngoingProject(_projectID);
    setState(() => isLoading = false);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchSpecificOngoingProjectData();

  }
  @override
  Widget build(BuildContext context) {
    // const Key centerKey = ValueKey<String>('bottom-sliver-list');
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: isLoading?
        Center(child: Loader()) : DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(

                  expandedHeight: 200.0,
                  floating: true,
                  pinned: true,
                  snap: true,
                  actionsIconTheme: IconThemeData(opacity: 0.0),
                  title: Container(
                      alignment: Alignment.center,
                      height: size.height*0.1,
                      decoration: BoxDecoration(
                          color: COLOR_GREEN.withOpacity(0.6)
                      ),
                      width: size.width,
                      child: Text(ongoingProject.crop.name)
                  ),
                  flexibleSpace: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Image.network(
                            ongoingProject.crop.imageURL,
                            fit: BoxFit.cover,
                          ))
                    ],
                  ),
                ),
                SliverPadding(
                  padding: new EdgeInsets.all(0),
                  sliver: new SliverList(
                    delegate: new SliverChildListDelegate([
                      Container(

                          height: size.height*0.1,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  COLOR_GREEN,
                                  COLOR_YELLOW
                                ],
                                begin: const FractionalOffset(0.2, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                          ),
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              ongoingProject.projectName,
                              style: TextStyle(

                                  fontSize: size.width*0.06,
                                  fontWeight: FontWeight.bold,
                                  color: COLOR_WHITE
                              ),
                            ),
                          )
                      ),
                      TabBar(
                        labelColor: Colors.black87,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          new Tab(icon: new Icon(Icons.task, color: COLOR_GREEN,), text: "Tasks To Do"),
                          new Tab(icon: new Icon(Icons.eco), text: "Crop Information"),

                        ],
                      ),
                    ]),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [

                if(!ongoingProject.initialization.purchaseStatus)
                  PurchaseStage(ongoingProject.projectID)
                else if(!ongoingProject.initialization.placeSelectionStatus)
                  PlaceSelectionStage(ongoingProject.projectID)
                else
                  ProjectTask(ongoingProject.projectID),
                ProjectCropInfo(ongoingProject)

              ],
            ),
          ),
        ));

  }
}







