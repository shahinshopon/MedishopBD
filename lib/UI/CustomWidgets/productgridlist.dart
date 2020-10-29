import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';
import 'package:medishop/ProductDetails/details.dart';

Widget ProductGridList(String collectionName) {
  return Padding(
    padding: EdgeInsets.all(SizeConfig.screenwidth * 0.035),
    child: StreamBuilder(
      stream: Firestore.instance.collection(collectionName).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.documents.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              DocumentSnapshot data = snapshot.data.documents[index];
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, CupertinoPageRoute(builder: (context)=>Details(data)));
                },
                child: Card(
                  elevation: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 0.5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.screenwidth * 0.015),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Center(
                            child: Container(
                                height: SizeConfig.screenwidth / 5,
                                width: SizeConfig.screenwidth / 4,
                                child: data["Product-image"] == null
                                    ? Center(
                                        child: Text("Loading"),
                                      )
                                    : Image.network(
                                        data["Product-image"],
                                        fit: BoxFit.fill,
                                      )),
                          ),
                          data["Product-name"] == null
                              ? Center(
                                  child: Text("Loading"),
                                )
                              : Text(
                                  data["Product-name"],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: SizeConfig.screenwidth * 0.038,
                                  ),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "\৳${data["previous-price"]}",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: SizeConfig.screenwidth * 0.03),
                              ),
                              Text(
                                data["offer"],
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w400,
                                    fontSize: SizeConfig.screenwidth * 0.03),
                              ),
                            ],
                          ),
                          Text(
                            "\৳${data["after-offer-price"]}",
                            style: TextStyle(
                                fontSize: SizeConfig.screenwidth * 0.042,
                                color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        else if (snapshot.hasError) {
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
  );
}
