import 'dart:convert';

import 'package:farm_buddy/model/plant/Crop.dart';
import 'package:farm_buddy/screens/farmbuddy/project/CreateProjectStepTwo_Screen.dart';
import 'package:farm_buddy/services/api_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'package:flutter/material.dart';

class CreatePlantingProjectStepOne extends StatefulWidget {

  @override
  _CreatePlantingProjectStepOneState createState() => _CreatePlantingProjectStepOneState();
}

class _CreatePlantingProjectStepOneState extends State<CreatePlantingProjectStepOne> {

  bool loading = false;

  List cropList1 = [];
  List <Crop> cropItemList = [];
  bool isLoading = true;
  String dropdownValue = 'Western';
  String seedingNote = '';
  fetchCropList(String state) async {
    setState(() => isLoading = true);
    APIService _apiService = new APIService();
    cropItemList =  await _apiService.fetchViableCropList(state.toLowerCase());
    for(Crop item in cropItemList){
      print(item.name);
    }
    setState(() => isLoading = false);
  }
  Future<void> refreshList(String value)async {
    setState(() {
      fetchCropList(value) ;
    });
  }
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
    if(predictionReport.isGoodToSeeding){
      seedingNote = ". It is a Good time to start Seeding with a new Project";
    }
    setState(() => isLoading = false);

  }

  @override
  Widget build(BuildContext context) {


    List cropList = [
      "1",
      "2"
    ];
    final Size size = MediaQuery.of(context).size;



    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(true),

        ),
        title: Text("Create Planting Project"),

      ),
      body: SingleChildScrollView(
        child: Center(
          child: isLoading?
          CircularProgressIndicator() :Stack(
            children: <Widget>[
              Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                ),
                child: Column(
                  children: [
                    Container(

                        height: size.height*0.1,
                        width: size.width *0.9,
                        child: Image.asset('assets/logo-cover.png')
                    ),
                    Container(
                      height: size.height*0.7829,
                      width: size.width *9,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Wrap(
                              children: [
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
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        text: 'Weather Prediction Report : \n',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.05, color: COLOR_WHITE),

                                      ),
                                    ),
                                  ),
                                ),
                                addVerticalSpace(size.height*0.09),
                                Container(
                                  width: size.width*0.9,
                                  height: size.height*0.2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: RichText(
                                      maxLines: null,
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(

                                          text: "This is the prediction report for the period " + predictionReport.duration +". " + predictionReport.predictionInfo +seedingNote,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),

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
                                      textAlign: TextAlign.justify,
                                      text: TextSpan(
                                        text: 'Choose a Crop to Start Project : \n',
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.05, color: COLOR_WHITE),

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
                                            TextSpan(text: "\t\t Please Select your Province to find out Viable Crops available to your area for current crop Season",
                                                style:  TextStyle(fontWeight: FontWeight.bold)
                                            )
                                          ]
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: size.height*0.09,
                                    width: size.width *0.9,
                                    child: Row(

                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Select Province :',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 19, color: COLOR_GREEN
                                              ),
                                            ),
                                            addHorizontalSpace(size.width*0.03),
                                            Container(
                                              width: size.width*0.4,
                                              child: DropdownButton<String>(

                                                value: dropdownValue,
                                                icon: const Icon(Icons.arrow_drop_down_circle_outlined),

                                                iconSize: 20,
                                                elevation: 10,
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
                                                    fetchCropList(newValue) ;
                                                  });
                                                },
                                                items: <String>['Western', 'Southern', 'Central', 'Eastern', 'Northern', 'North-Western', 'North-Central', 'Uva', 'Sabaragamuwa']
                                                    .map<DropdownMenuItem<String>>((String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.gps_fixed),
                                                        addHorizontalSpace(size.width*0.04),
                                                        Text(value)
                                                      ],
                                                    ),

                                                  );
                                                }).toList(),
                                                // Month Field
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height*0.01,),
                                Container(
                                  child: Center(
                                    child: isLoading?
                                    CircularProgressIndicator() :Container(
                                      color: COLOR_WHITE,
                                      width: size.width*0.9,
                                      height: size.height*0.4,
                                      child: RefreshIndicator(
                                        onRefresh: () async {
                                          return refreshList(dropdownValue);
                                        },
                                        child: ListView.builder(
                                          itemCount: cropItemList.length,
                                          itemBuilder: (context, index) {
                                            return Card(
                                              child: ListTile(
                                                title: Row(
                                                  children: [
                                                    Container(
                                                      width: size.width *0.15,
                                                      height: size.height*0.09,
                                                      decoration: BoxDecoration(
                                                          color: COLOR_GREEN,
                                                          borderRadius: BorderRadius.circular(size.width *0.15/2),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(cropItemList[index].imageURL)
                                                          )
                                                      ),
                                                    ),
                                                    SizedBox(width: size.width*0.05,),
                                                    Column(

                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          cropItemList[index].name,
                                                          style: TextStyle(
                                                              fontSize: size.width*0.04,
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                        SizedBox(height: size.height*0.01,),
                                                        Text(
                                                          'In ' +cropItemList[index].lifeSpan.toString() +' days',
                                                          style: TextStyle(
                                                              fontSize:size.width*0.04,
                                                              fontWeight: FontWeight.bold,
                                                              color: COLOR_GREEN
                                                          ),
                                                        )
                                                      ],
                                                    ),

                                                  ],
                                                ),
                                                onTap: (){
                                                  debugPrint("List Tile Tapped");
                                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                                    return ViewViableCrop(cropItemList[index]);
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
                              ]
                            ),
                          ),

                        ],
                      ),
                    ),



                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
