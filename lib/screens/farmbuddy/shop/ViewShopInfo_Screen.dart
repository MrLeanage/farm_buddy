
import 'package:farm_buddy/model/shop/Shop.dart';
import 'package:farm_buddy/screens/farmbuddy/shop/ShopInfo_Screen.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:flutter/material.dart';

class ViewShopScreen extends StatefulWidget {
  Shop _shop;


  ViewShopScreen(this._shop);

  @override
  _ViewShopScreenState createState() => _ViewShopScreenState(this._shop);
}

class _ViewShopScreenState extends State<ViewShopScreen> {
  Shop _shop;
  _ViewShopScreenState(this._shop);



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
                          color: COLOR_GREEN.withOpacity(0.6)
                      ),
                      width: size.width,
                      child: Text(_shop.shopName)
                  ),
                  // flexibleSpace: Stack(
                  //   children: <Widget>[
                  //     Positioned.fill(
                  //         child: Image.network(
                  //           ongoingProject.crop.imageURL,
                  //           fit: BoxFit.cover,
                  //         ))
                  //   ],
                  // ),
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
                              _shop.shopName + " "+_shop.shopCity,
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
                          new Tab(icon: new Icon(Icons.home_work, color: COLOR_GREEN,), text: "Shop Information"),

                        ],
                      ),
                    ]),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                ShopInfoScreen(_shop)

              ],
            ),
          ),
        ));

  }
}







