import 'package:farm_buddy/model/plant/Crop.dart';
import 'package:farm_buddy/screens/farmbuddy/app_home/AppBase_Screen.dart';
import 'package:farm_buddy/services/api_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/toastMessage.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ViewViableCrop extends StatefulWidget {
Crop _crop;


ViewViableCrop(this._crop);

@override
  _ViewViableCropState createState() => _ViewViableCropState(this._crop);
}

class _ViewViableCropState extends State<ViewViableCrop> {

Crop _crop;
List<int> top = <int>[];
List<int> bottom = <int>[0];

_ViewViableCropState(this._crop);

  @override
  Widget build(BuildContext context) {
   // const Key centerKey = ValueKey<String>('bottom-sliver-list');
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: DefaultTabController(
          length: 1,
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
                      color: COLOR_GREEN.withOpacity(0.5)
                    ),
                    width: size.width,
                      child: Text(_crop.name)
                  ),
                  flexibleSpace: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Image.network(
                            _crop.imageURL,
                            fit: BoxFit.cover,
                          ))
                    ],
                  ),
                ),
                SliverPadding(
                  padding: new EdgeInsets.all(16.0),
                  sliver: new SliverList(
                    delegate: new SliverChildListDelegate([
                      TabBar(
                        labelColor: Colors.black87,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          new Tab(icon: new Icon(Icons.info), text: "Crop Information"),
                        ],
                      ),
                    ]),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [

                CropInfo(_crop),
              ],
            ),
          ),
        ));

  }
}
class CropInfo extends StatefulWidget {
  Crop _crop;

  CropInfo(this._crop);

  @override
  _CropInfoState createState() => _CropInfoState(this._crop);
}

class _CropInfoState extends State<CropInfo> {
  Crop _crop;
  _CropInfoState(this._crop);
  bool isProjectAdded = true;
  createProject(String cropID, String projectName) async {
    //setState(() => isProjectAdded = true);
    APIService apiService = new APIService();
    if(await apiService.createPlantingProject(cropID, projectName) == true){
      setState(() => isProjectAdded = false);
      ToastMessage.showSuccessToast("Project Created Successfully!");
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context){
                return HomeScreen(1);
              }));
    }else{
      ToastMessage.showSuccessToast("Error Occurred While Creating the Project. \nTry Again!");
    }
  }
  @override
  Widget build(BuildContext context) {
    String cropPreNote = "";
    String projectName = "";

    if(_crop.cropNoteStatus){
      cropPreNote = "This plant can grow in your Area. ";
    }else{
      cropPreNote = "This plant can't grow in your Area. ";
    }
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
                                  text: _crop.name,

                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.06, color: COLOR_WHITE),
                                ),

                              ),
                            ),
                          ],
                        ),

                      ),
                      addVerticalSpace(size.height*0.09),
                      Container(

                        child: RichText(
                          maxLines: null,
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            text: _crop.description,

                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18, color: COLOR_BLACK),
                          ),
                        ),
                      ),
                      addVerticalSpace(size.height*0.4),
                      Container(
                        width: size.width*0.9,
                        child: RichText(
                          maxLines: null,
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                              text: 'Place Selection Type : \n',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK, ),
                              children: [
                                TextSpan(text: "\t\t"+_crop.placeName,
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
                              text: 'Life Span : \n',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                              children: [
                                TextSpan(text: "\t\t"+_crop.lifeSpan + " Days",
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

                              text: 'Viable Status : \n',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                              children: [
                                TextSpan(text: "\t\t"+cropPreNote+_crop.cropNoteMsg ,
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
                                title: "PROVIDE A NAME TO PROJECT",
                                desc: _crop.name,
                                style: AlertStyle(
                                  titleStyle: TextStyle(color: COLOR_GREEN, fontSize: size.width*0.05),
                                  descStyle: TextStyle(color: COLOR_BLACK, fontSize:  size.width*0.04),

                                ),
                                content: Column(
                                  children: <Widget>[

                                    TextFormField(
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.eco, color: COLOR_GREEN,),
                                        labelText: 'Project Name',
                                      ),

                                      validator: (value){
                                        if(value!.length == 0){
                                          return 'Project Name cannot be Empty';
                                        }else if(value.length <= 5 ){
                                          return 'Project Name is too Short';
                                        }
                                        return null;
                                      },
                                      onChanged: (value){
                                        setState(() => projectName = value);
                                      },
                                    ),

                                  ],
                                ),
                                buttons: [
                                  DialogButton(
                                    // onPressed: () => Navigator.pop(context),
                                    onPressed: () =>{
                                      createProject(_crop.cropID, projectName),
                                    },

                                    child: Text(
                                      "CREATE",
                                      style: TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                    gradient: LinearGradient(colors: [
                                      COLOR_GREEN,
                                      COLOR_YELLOW
                                    ]),
                                  ),
                                  DialogButton(
                                    // onPressed: () => Navigator.pop(context),
                                    onPressed: () =>{
                                      Navigator.pop(context)
                                    },

                                    child: Text(
                                      "Cancel",
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
                                'SELECT THIS CROP FOR PLANTING',
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
        )
    );
  }
}

class Prediction extends StatefulWidget {
  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  var predictionReport;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchPredictionData();

  }
  fetchPredictionData() async {
    print("Init Called ");
    APIService apiService = new APIService();
    predictionReport = await apiService.fetchCropWeatherPrediction();
    print(predictionReport.duration);
  }
  @override
  Widget build(BuildContext context) {
    //final Size size = MediaQuery.of(context).size;
    return Container();
  }
}



