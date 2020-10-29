import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';
import 'package:medishop/UI/CustomWidgets/custombutton.dart';
import 'package:medishop/UI/CustomWidgets/textboxtitle.dart';
import 'package:medishop/logic/login.dart';
import 'package:provider/provider.dart';

import '../bottomnavcontroller.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  double total = 0.0;
  double sizeboxheightvalue = SizeConfig.screenwidth * 0.015;
  final _formkey = GlobalKey<FormState>();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController latloncontroller = TextEditingController();

  var itemlist;

  LocationData myLocation;
  getUserLocation() async {
    //call this async method from whereever you need

    String error;
    Location location = new Location();
    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      myLocation = null;
    }
    // currentLocation = myLocation;
    final coordinates =
        new Coordinates(myLocation.latitude, myLocation.longitude);
    latloncontroller.text = "$coordinates";
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    locationcontroller.text = ('${first.featureName},${first.subAdminArea}');
    return first;
  }

  void queryValues(String uid) {
    Firestore.instance
        .collection("Checkout")
        .document(uid)
        .collection("cartlist")
        .snapshots()
        .listen((snapshot) {
      double tempTotal = snapshot.documents
          .fold(0, (tot, doc) => tot + doc.data['after-offer-price']*doc.data['quantity']);
      setState(() {
        total = tempTotal;
      });
      debugPrint(total.toString());
    });
  }

  void SendData(String uid, TextEditingController name, phonenumber, location,
      latlong) async {
    Firestore.instance
        .collection("Checkout")
        .document(uid)
        .collection("cartlist")
        .getDocuments()
        .then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        Map<String, dynamic> data = {
          //"Status": firstName + " $lastName",
          "userID": uid,
          "Username": name.text,
          "UserPhone": phonenumber.text,
          "Delivery-Location": location.text,
          "lat-long": latlong.text,
          "prooducts": result.data,
          "total": total
        };

        Firestore.instance
            .collection("Place-Order")
            .document(uid)
            .collection("productlist")
            .document()
            .setData(
              data,
            );
      });
    });
  }

  @override
  void initState() {
    getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerdata = Provider.of<UserLogin>(context);
    queryValues(providerdata.userid);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        title: Text("Selected Items"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 10,
                child: Container(
                  child: StreamBuilder(
                    stream: Firestore.instance
                        .collection("Checkout")
                        .document(providerdata.userid)
                        .collection("cartlist")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot dataa =
                                snapshot.data.documents[index];
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                leading: Container(
                                  height: SizeConfig.screenheight * 0.2,
                                  width: SizeConfig.screenwidth * 0.2,
                                  child: Image.network(
                                    dataa["Product-image"],
                                  ),
                                ),
                                title: Text(
                                  dataa["product-name"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: SizeConfig.screenwidth * 0.038,
                                  ),
                                ),
                                subtitle: Text(
                                  "\৳${dataa["after-offer-price"]}, Quantity: ${dataa["quantity"]}",
                                  style: TextStyle(
                                      fontSize: SizeConfig.screenwidth * 0.038,
                                      color: Colors.blue),
                                ),
                                trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.grey,
                                      size: SizeConfig.screenheight * 0.03,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        Firestore.instance
                                            .collection("Checkout")
                                            .document(providerdata.userid)
                                            .collection("cartlist")
                                            .document(snapshot.data
                                                .documents[index].documentID)
                                            .delete();
                                      });
                                    }),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                            child: CircularProgressIndicator(
                          backgroundColor: Colors.orange,
                        ));
                      }
                      return Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Colors.orange,
                      ));
                    },
                  ),
                )),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: SizeConfig.screenwidth / 2.2,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                SizeConfig.screenheight * 0.05))),
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.screenheight * 0.012),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Total \৳$total",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.screenheight * 0.02),
                          ),

                          //Text("Delivery Charge : ${}"),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      width: SizeConfig.screenwidth / 2.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  SizeConfig.screenheight * 0.05))),
                      child: Material(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  SizeConfig.screenheight * 0.05)),
                          color: Colors.green,
                          child: InkWell(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    SizeConfig.screenheight * 0.05)),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: Radius.circular(
                                              SizeConfig.screenheight * 0.03),
                                          topRight: Radius.circular(
                                              SizeConfig.screenheight * 0.03),
                                        ),
                                      ),
                                      child: Container(
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              SizeConfig.screenheight * 0.025),
                                          child: Wrap(
                                            children: <Widget>[
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  TitleText("Enter your name"),
                                                  SizedBox(
                                                    height: sizeboxheightvalue,
                                                  ),

                                                  // text field started

                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: Form(
                                                      key: _formkey,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Container(
                                                            height: SizeConfig
                                                                    .screenheight /
                                                                15,
                                                            width: SizeConfig
                                                                .screenwidth,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .green)),
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: SizeConfig
                                                                          .screenwidth *
                                                                      0.03,
                                                                  right: SizeConfig
                                                                          .screenwidth *
                                                                      0.03),
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                      .isEmpty) {
                                                                    return "Enter Your Full Name";
                                                                  }
                                                                },
                                                                controller:
                                                                    namecontroller,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Segoe UI",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .screenwidth *
                                                                          0.045,
                                                                  color: Color(
                                                                      0xff000000),
                                                                ),
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "Segoe UI",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        SizeConfig.screenwidth *
                                                                            0.045,
                                                                    color: Colors
                                                                        .black38,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                sizeboxheightvalue,
                                                          ),
                                                          TitleText(
                                                              "Enter phone number"),
                                                          SizedBox(
                                                            height:
                                                                sizeboxheightvalue,
                                                          ),
                                                          Container(
                                                            height: SizeConfig
                                                                    .screenheight /
                                                                15,
                                                            width: SizeConfig
                                                                .screenwidth,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .green)),
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: SizeConfig
                                                                          .screenwidth *
                                                                      0.03,
                                                                  right: SizeConfig
                                                                          .screenwidth *
                                                                      0.03),
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                          .length <
                                                                      11) {
                                                                    return "Enter Correct Number";
                                                                  }
                                                                },
                                                                controller:
                                                                    phonenumbercontroller,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Segoe UI",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .screenwidth *
                                                                          0.045,
                                                                  color: Color(
                                                                      0xff000000),
                                                                ),
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "Segoe UI",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        SizeConfig.screenwidth *
                                                                            0.045,
                                                                    color: Colors
                                                                        .black38,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                sizeboxheightvalue,
                                                          ),
                                                          TitleText(
                                                              "Select or enter your area"),
                                                          SizedBox(
                                                            height:
                                                                sizeboxheightvalue,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Container(
                                                                height: SizeConfig
                                                                        .screenheight /
                                                                    15,
                                                                width: SizeConfig
                                                                        .screenwidth /
                                                                    1.5,
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .green)),
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(
                                                                      left: SizeConfig
                                                                              .screenwidth *
                                                                          0.03,
                                                                      right: SizeConfig
                                                                              .screenwidth *
                                                                          0.03),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        locationcontroller,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "Segoe UI",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          SizeConfig.screenwidth *
                                                                              0.045,
                                                                      color: Color(
                                                                          0xff000000),
                                                                    ),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Segoe UI",
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontSize:
                                                                            SizeConfig.screenwidth *
                                                                                0.045,
                                                                        color: Colors
                                                                            .black38,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: SizeConfig
                                                                        .screenheight /
                                                                    20,
                                                                width: SizeConfig
                                                                        .screenwidth *
                                                                    0.2,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5)),
                                                                ),
                                                                child: Material(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              5)),
                                                                  color: Colors
                                                                      .green,
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      getUserLocation();
                                                                    },
                                                                    splashColor:
                                                                        Colors
                                                                            .red,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "Select",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: SizeConfig.screenwidth * 0.04),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                sizeboxheightvalue,
                                                          ),
                                                          TitleText(
                                                              "Latitude & Longitude"),
                                                          SizedBox(
                                                            height:
                                                                sizeboxheightvalue,
                                                          ),
                                                          Container(
                                                            height: SizeConfig
                                                                    .screenheight /
                                                                15,
                                                            width: SizeConfig
                                                                    .screenwidth /
                                                                1.5,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .green)),
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  left: SizeConfig
                                                                          .screenwidth *
                                                                      0.03,
                                                                  right: SizeConfig
                                                                          .screenwidth *
                                                                      0.03),
                                                              child:
                                                                  TextFormField(
                                                                validator:
                                                                    (value) {
                                                                  if (value
                                                                      .isEmpty) {
                                                                    return "Click On Select Button";
                                                                  }
                                                                },
                                                                controller:
                                                                    latloncontroller,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Segoe UI",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      SizeConfig
                                                                              .screenwidth *
                                                                          0.045,
                                                                  color: Color(
                                                                      0xff000000),
                                                                ),
                                                                decoration:
                                                                    InputDecoration(
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "Segoe UI",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        SizeConfig.screenwidth *
                                                                            0.045,
                                                                    color: Colors
                                                                        .black38,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  // textfield finish

                                                  SizedBox(
                                                    height:
                                                        SizeConfig.screenwidth *
                                                            0.15,
                                                  ),
                                                  CustomButton(
                                                    "Continue",
                                                    () {
                                                      if (_formkey.currentState
                                                          .validate()) {
                                                        SendData(
                                                            providerdata.userid,
                                                            namecontroller,
                                                            phonenumbercontroller,
                                                            latloncontroller,
                                                            latloncontroller);

                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible:
                                                              false,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "Uploadded Successfully !"),
                                                              content: Text(
                                                                  "We will call you as quick as possible to confirm the order."),
                                                              actions: <Widget>[
                                                                RaisedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.push(
                                                                        context,
                                                                        CupertinoPageRoute(
                                                                            builder: (context) =>
                                                                                BottomNavController()));
                                                                  },
                                                                  child: Text(
                                                                      "Ok"),
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      }
                                                    },
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            },
                            splashColor: Colors.white,
                            child: Center(
                              child: Text(
                                "Place Order",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.screenheight * 0.024),
                              ),
                            ),
                          ))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
