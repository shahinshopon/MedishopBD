import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';
import 'package:medishop/UI/BottomNav/Pages/shoppingcart.dart';
import 'package:medishop/logic/login.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  DocumentSnapshot data;
  Details(this.data);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final db = Firestore.instance;

  int quantity = 1;
  int addedtocart = 0;
  bool value  = false;
  int cartlength=0;



  @override
  Widget build(BuildContext context) {


    final providerdata = Provider.of<UserLogin>(context);



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Details"),
        actions: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(context, CupertinoPageRoute(builder: (context) => ShoppingCart()));
            },
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                     Navigator.push(context, CupertinoPageRoute(builder: (context) => ShoppingCart()));
                  },
                  icon: Icon(Icons.shopping_cart),
                ),

                Positioned(child: StreamBuilder(
                    stream: Firestore.instance
                        .collection("Checkout")
                        .document(providerdata.userid)
                        .collection("cartlist")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {

                        return Text("${snapshot.data.documents.length}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),);
                      }
                      return Center(
                          );
                    },



                    //child: Text("${cartlength}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                )),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.screenheight * 0.02,
                    right: SizeConfig.screenheight * 0.02,
                    top: SizeConfig.screenheight * 0.02),
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // product name

                        widget.data["Product-name"] == null
                            ? Center(
                                child: Text("Loading"),
                              )
                            : Text(
                                widget.data["Product-name"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.screenwidth * 0.05,
                                ),
                              ),

                        SizedBox(
                          height: SizeConfig.screenheight * 0.03,
                        ),

                        // product image
                        widget.data['Product-image'] == null
                            ? Text("Image Loading")
                            : Card(
                                child: Container(
                                    height: SizeConfig.screenheight / 5,
                                    width: SizeConfig.screenwidth,
                                    child: Image.network(
                                      widget.data['Product-image'],
                                      fit: BoxFit.cover,
                                    )),
                              ),

                        SizedBox(
                          height: SizeConfig.screenheight * 0.03,
                        ),

                        // Card

                        Card(
                          elevation: 5,
                          child: Container(
                            height: SizeConfig.screenheight / 9,
                            width: SizeConfig.screenwidth,
                            child: Padding(
                              padding: EdgeInsets.all(
                                  SizeConfig.screenheight * 0.01),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "Best Price",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              SizeConfig.screenwidth * 0.04,
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.screenheight * 0.03,
                                      ),
                                      widget.data["after-offer-price"] == null
                                          ? Center(
                                              child: Text("Loading"),
                                            )
                                          : Text(
                                              "\৳${quantity*widget.data["after-offer-price"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    SizeConfig.screenwidth *
                                                        0.06,
                                              ),
                                            ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "MRP",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              SizeConfig.screenwidth * 0.04,
                                        ),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.screenheight * 0.01,
                                      ),
                                      widget.data["previous-price"] == null
                                          ? Center(
                                              child: Text("Loading"),
                                            )
                                          : Text(
                                              "\৳${quantity*widget.data["previous-price"]}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    SizeConfig.screenwidth *
                                                        0.04,
                                              ),
                                            ),
                                      SizedBox(
                                        width: SizeConfig.screenheight * 0.025,
                                      ),
                                      widget.data["offer"] == null
                                          ? Center(
                                              child: Text("Loading"),
                                            )
                                          : Text(
                                              widget.data["offer"],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    SizeConfig.screenwidth *
                                                        0.045,
                                              ),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: SizeConfig.screenheight * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: "btn1",
                              onPressed: () {
                                setState(() {
                                  value==false?quantity++:"";
                                },);
                              },
                              child: Text(
                                "+",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.screenheight * 0.045),
                              ),
                              backgroundColor: Colors.green,
                            ),
                            Text("$quantity Piece",style: TextStyle(fontWeight: FontWeight.bold,fontSize: SizeConfig.screenheight*0.04,color: Colors.pink),),
                            FloatingActionButton(
                              heroTag: "btn2",
                              onPressed: () {
                                if(quantity!=1){
                                  setState(() {
                                    value==false?quantity--:"";
                                  });
                                }

                              },
                              child: Text(
                                "-",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.screenheight * 0.045),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          ],
                        ),

                        SizedBox(
                          height: SizeConfig.screenheight * 0.04,
                        ),

                        // product description
                        widget.data["Product-description"] == null
                            ? Center(
                                child: Text("Loading"),
                              )
                            : Text(
                                widget.data["Product-description"],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: SizeConfig.screenwidth * 0.038,
                                ),
                              ),

                        SizedBox(
                          height: SizeConfig.screenheight * 0.04,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight:
                            Radius.circular(SizeConfig.screenheight * 0.09)),
                  ),child: value==false?
              Material(
                      borderRadius: BorderRadius.only(
                          topRight:
                              Radius.circular(SizeConfig.screenheight * 0.09)),
                      color: value==false?Colors.green:Colors.white,
                      child: InkWell(
                        onTap: () {

                         value==false? db
                              .collection("Checkout")
                              .document(providerdata.userid)
                              .collection("cartlist")
                              .add(
                            {
                              'product-name': widget.data['Product-name'],
                              'Product-image': widget.data['Product-image'],
                              'quantity*after-offer-price': quantity*widget.data['after-offer-price'],
                              'document-id': widget.data.reference,
                              'quantity':quantity,
                              'after-offer-price':widget.data['after-offer-price']

                            },
                          ): Fluttertoast.showToast(msg: "Already Added",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);;


                          Fluttertoast.showToast(msg: "Added Successfully",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);
                          setState(() {
                            value==false?addedtocart++:"";
                            value=true;
                          });

                        },
                        splashColor: Colors.white,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                              size: SizeConfig.screenheight * 0.04,
                            ),
                            SizedBox(
                              width: SizeConfig.screenheight * 0.02,
                            ),
                            value==false?Text(
                              "Add to cart",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.screenwidth * 0.05),
                            ): Text(
                              "Already Added",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.screenwidth * 0.05),
                            )   ,
                          ],
                        )),
                      )):Center(child: Text("Successfull.Check The Cart Page",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))),
            ),
          ],
        ),
      ),
    );
  }

}
