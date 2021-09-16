
import 'package:farm_buddy/model/shop/Shop.dart';
import 'package:farm_buddy/utils/constants.dart';
import 'package:farm_buddy/utils/custom_widgets/addSpace_widget.dart';
import 'package:flutter/material.dart';

class ShopInfoScreen extends StatefulWidget {
  Shop _shop;

  ShopInfoScreen(this._shop);

  @override
  _ShopInfoScreenState createState() => _ShopInfoScreenState(this._shop);
}

class _ShopInfoScreenState extends State<ShopInfoScreen> {
  Shop _shop;
  _ShopInfoScreenState(this._shop);
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

                        child: RichText(
                          maxLines: null,
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: _shop.shopName + ", " +_shop.shopCity,

                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.058, color: COLOR_GREEN),
                          ),

                        ),

                      ),
                      addVerticalSpace(size.height*0.15),
                      Container(
                        width: size.width*0.9,
                        height: size.height*0.055,
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
                              text: "Province : " +_shop.shopProvince,

                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.05, color: COLOR_WHITE),
                            ),

                          ),
                        ),

                      ),
                      addVerticalSpace(size.height*0.09),
                      Container(
                        width: size.width*0.9,
                        height: size.height*0.055,
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
                                text: 'Contact Person Information : \n',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_WHITE, ),

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
                            textAlign: TextAlign.right,
                            text: TextSpan(

                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                                children: [
                                  TextSpan(text:  "\t\t"+_shop.shopContactName  + " ("+_shop.shopContactPosition+")"+"\n",
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
                        height: size.height*0.055,
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
                                text: 'Contact Number : \n',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_WHITE),

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
                            textAlign: TextAlign.right,
                            text: TextSpan(

                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: COLOR_BLACK),
                                children: [
                                  TextSpan(text: "\t\t"+_shop.shopContactLandPhone + "\n"+"\t\t"+_shop.shopContactMobilePhone,
                                      style:  TextStyle(fontWeight: FontWeight.bold)
                                  )
                                ]
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpace(size.height*0.09)
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