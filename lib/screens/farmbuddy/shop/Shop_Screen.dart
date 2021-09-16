import 'dart:ui';


import 'package:farm_buddy/model/shop/Shop.dart';
import 'package:farm_buddy/screens/farmbuddy/shop/ViewShopInfo_Screen.dart';
import 'package:farm_buddy/services/api_service.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/appBar.dart';
import 'package:farm_buddy/utils/custom_widgets/pageHeading_widget.dart';
import 'package:farm_buddy/utils/custom_widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';
class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with SingleTickerProviderStateMixin{
  bool isLoading = false;
  late List<Shop> shopList = [];

  var onGoingProjects;


  fetchShopList() async {
    print("Init Called ");
    APIService apiService = new APIService();
    shopList =  await apiService.fetchShopList();

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
    this.fetchShopList();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = window.physicalSize.width;
    final double screenHeight = window.physicalSize.height;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideBar(),
      backgroundColor: COLOR_BACKGROUND,

      body: Column(
        children: [
          customAppBar(screenHeight, screenWidth, _scaffoldKey),
          PageHeadingWidget("Vegetable Seed Outlets",Icons.shop, screenHeight, screenWidth),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Container(

              height: screenHeight*0.176,
              width: screenWidth * 0.27,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.005),
                  color: COLOR_WHITE
              ),
              child: Stack(
                children: [

                  Column(
                    children: [
                      Center(
                        child: Container(
                          width: size.width*0.9,
                          height: size.height*0.61,
                          child: Center(
                            child: isLoading?
                            CircularProgressIndicator() :Container(
                              color: COLOR_WHITE,
                              width: size.width*0.9,
                              height: size.height*0.65,
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  return fetchShopList();
                                },
                                child: ListView.builder(
                                  itemCount: shopList.length,
                                  itemBuilder: (context, index) {
                                    return Card(

                                      child: ListTile(

                                        tileColor: Colors.grey[300],
                                        dense:true,
                                        contentPadding: EdgeInsets.symmetric(vertical: size.height*0.04, horizontal:
                                        size.height*0.02),
                                        title: Row(

                                          children: [
                                            Container(
                                              child:FittedBox(
                                                  child: Icon(Icons.home_work, color: COLOR_WHITE, size: size.width*0.09,),
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
                                                        text: shopList[index].shopName.toString()+'\n',
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                                                        children: [
                                                          TextSpan(text: shopList[index].shopCity.toString(),
                                                              style:  TextStyle(fontWeight: FontWeight.normal)
                                                          )
                                                        ]
                                                    ),
                                                  ),
                                                ),
                                                // Text(
                                                //   shopList[index].shopName,
                                                //   style: TextStyle(
                                                //       fontSize: size.width*0.04,
                                                //       fontWeight: FontWeight.bold
                                                //   ),
                                                // ),
                                                SizedBox(height: size.height*0.01,),

                                              ],
                                            ),

                                          ],
                                        ),
                                        onTap: (){
                                          debugPrint("List Tile Tapped");
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return ViewShopScreen(shopList[index]);
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
    );
  }
}

