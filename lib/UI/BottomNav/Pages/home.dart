import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';
import 'package:medishop/UI/BottomNav/Pages/help.dart';
import 'package:medishop/UI/BottomNav/Pages/shoppingcart.dart';
import 'package:medishop/UI/BottomNav/Pages/uploadprescription.dart';
import 'package:medishop/UI/CustomWidgets/customItem.dart';
import 'package:medishop/UI/CustomWidgets/fetchcategory.dart';
import 'package:medishop/UI/CustomWidgets/productlisthorizontal.dart';
import 'package:medishop/UI/CustomWidgets/textwidget.dart';
import 'package:medishop/UI/DrawerPages/contactwithus.dart';
import 'package:medishop/UI/SeeAll/categoryeight.dart';
import 'package:medishop/UI/SeeAll/categoryfive.dart';
import 'package:medishop/UI/SeeAll/categoryfour.dart';
import 'package:medishop/UI/SeeAll/categorynine.dart';
import 'package:medishop/UI/SeeAll/categoryone.dart';
import 'package:medishop/UI/SeeAll/categoryseven.dart';
import 'package:medishop/UI/SeeAll/categorysix.dart';
import 'package:medishop/UI/SeeAll/categoryten.dart';
import 'package:medishop/UI/SeeAll/categorythree.dart';
import 'package:medishop/UI/SeeAll/categorytwo.dart';
import 'package:medishop/logic/login.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'medicinerequest.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double sizeboxheight = SizeConfig.screenwidth * 0.04;

  Future getimgforCarousel() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn =
        await firestore.collection("Carousel-Images").getDocuments();
    return qn.documents;
  }
  LaunchURL() async {
    const url = 'https://m.facebook.com/Medishopbd-116340780212279/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    getimgforCarousel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerdata = Provider.of<UserLogin>(context);

    return Scaffold(

      endDrawer: Drawer(

        child: SafeArea(
          child: Container(

            child: Padding(
              padding:  EdgeInsets.all(SizeConfig.screenheight*0.02),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: SizeConfig.screenheight / 10,
                      width: SizeConfig.screenwidth / 1.5,
                      child: Image.asset(
                        "images/splashlogo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenheight*0.03,),
                    // contact
                    Card(
                      elevation: 6,
                        child: ListTile(
                      title: Text("Contact"),
                          leading: Icon(Icons.contact_phone),
                          onTap: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context)=>ContactWithUs()));
                          },
                    )),
                    // help
                    Card(
                        elevation: 6,

                        child: ListTile(
                      title: Text("Help"),
                          leading: Icon(Icons.help),
                          onTap: (){
                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>HelpPage()));
                          },
                    )),
                    // privacy
                    Card(
                        elevation: 6,

                        child: ListTile(
                      title: Text("Privacy"),
                          leading: Icon(Icons.block),
                    )),
                    // rate
                    Card(

                        elevation: 6,

                        child: ListTile(
                      title: Text("Rate Us"),
                          leading: Icon(Icons.star),
                    )),
                    // share
                    Card(
                        elevation: 6,

                        child: ListTile(
                      title: Text("Share"),
                          leading: Icon(Icons.share),
                    )),
                    // facebook
                    Card(
                        elevation: 6,

                        child: ListTile(
                      title: Text("Facebook Page"),
                          leading: Text(" f",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: SizeConfig.screenheight*0.042),),
                          onTap: (){
                          LaunchURL();
                          },
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("MediShop BD"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Container(
                height: SizeConfig.screenheight / 5,
                width: SizeConfig.screenwidth,
                child: FutureBuilder(
                  future: getimgforCarousel(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CarouselSlider.builder(
                        enableAutoSlider: true,
                        unlimitedMode: true,
                        slideBuilder: (index) {
                          DocumentSnapshot sliderimages = snapshot.data[index];
                          return GestureDetector(
                            child: Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        SizeConfig.screenwidth * 0.06),
                                    bottomRight: Radius.circular(
                                        SizeConfig.screenwidth * 0.06)),
                                child: Image.network(
                                  sliderimages['img'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        },
                        slideTransform: CubeTransform(
                          rotationAngle: 0,
                        ),
                        slideIndicator: CircularSlideIndicator(
                            indicatorBackgroundColor: Colors.white,
                            currentIndicatorColor: Colors.indigo,
                            padding: EdgeInsets.only(bottom: 10),
                            indicatorRadius: 4),
                        itemCount: snapshot.data.length,
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
              ),
              Padding(
                padding: EdgeInsets.all(SizeConfig.screenwidth * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      child: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CustomItem(
                              SizeConfig.screenwidth * 0.2,
                              SizeConfig.screenwidth * 0.35,
                              Icons.add_circle,
                              "Upload Prescription",
                              () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            UploadPrescription()));
                              },
                            ),
                            SizedBox(
                              width: SizeConfig.screenwidth * 0.015,
                            ),
                            CustomItem(
                              SizeConfig.screenwidth * 0.2,
                              SizeConfig.screenwidth * 0.35,
                              Icons.phone_in_talk,
                              "Medicine Request",
                              () {
                                Navigator.push(context, CupertinoPageRoute(builder: (context) => MedicineRequest()));
                              },
                            ),
                            SizedBox(
                              width: SizeConfig.screenwidth * 0.015,
                            ),
                            Stack(
                              alignment: Alignment.topCenter,

                              children: <Widget>[
                                Container(
                                    height:SizeConfig.screenwidth * 0.2,
                                    width:SizeConfig.screenwidth * 0.35,
                                    decoration: BoxDecoration(

                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Material(
                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                        color: Colors.green,
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.push(context, CupertinoPageRoute(builder: (context)=>ShoppingCart()));
                                          },
                                          splashColor: Colors.white,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(Icons.add_shopping_cart,color: Colors.white,size: 25,),
                                                SizedBox(height: SizeConfig.screenwidth*0.01,),

                                                Text(
                                                  "Added To Cart",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: SizeConfig.screenwidth*0.030),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))),
                                Positioned(

                                    child: StreamBuilder(
                                      stream: Firestore.instance
                                          .collection("Checkout")
                                          .document(providerdata.userid)
                                          .collection("cartlist")
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {

                                          return CircleAvatar(backgroundColor: Colors.red,radius: SizeConfig.screenheight*0.009,child: Text("${snapshot.data.documents.length}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: SizeConfig.screenheight*0.015),));
                                        }
                                        return Center(
                                        );
                                      },
                                    )),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizeboxheight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FetchCategoryName(context, "0"),
                        SeeAllTextWidget(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryOne()));
                        }),
                      ],
                    ),
                    HorizontalProductsList("Category-one"),
                    SizedBox(
                      height: sizeboxheight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FetchCategoryName(context, "1"),
                        SeeAllTextWidget(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryTwo()));
                        }),
                      ],
                    ),
                    HorizontalProductsList("Category-two"),
                    SizedBox(
                      height: sizeboxheight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FetchCategoryName(context, "2"),
                        SeeAllTextWidget(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryThree()));
                        }),
                      ],
                    ),
                    HorizontalProductsList("Category-three"),
                    SizedBox(
                      height: sizeboxheight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FetchCategoryName(context, "3"),
                        SeeAllTextWidget(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryFour()));
                        }),
                      ],
                    ),
                    HorizontalProductsList("Category-four"),
                    SizedBox(
                      height: sizeboxheight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FetchCategoryName(context, "4"),
                        SeeAllTextWidget(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryFive()));
                        }),
                      ],
                    ),
                    HorizontalProductsList("Category-five"),
                    SizedBox(
                      height: sizeboxheight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FetchCategoryName(context, "5"),
                        SeeAllTextWidget(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategorySix()));
                        }),
                      ],
                    ),
                    HorizontalProductsList("Category-six"),
                    SizedBox(
                      height: sizeboxheight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FetchCategoryName(context, "6"),
                        SeeAllTextWidget(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategorySeven()));
                        }),
                      ],
                    ),
                    HorizontalProductsList("Category-seven"),
                    SizedBox(
                      height: sizeboxheight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FetchCategoryName(context, "7"),
                        SeeAllTextWidget(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryEight()));
                        }),
                      ],
                    ),
                    HorizontalProductsList("Category-eight"),
                    SizedBox(
                      height: sizeboxheight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FetchCategoryName(context, "8"),
                        SeeAllTextWidget(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryNine()));
                        }),
                      ],
                    ),
                    HorizontalProductsList("Category-nine"),
                    SizedBox(
                      height: sizeboxheight,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FetchCategoryName(context, "9"),
                        SeeAllTextWidget(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CategoryTen()));
                        }),
                      ],
                    ),
                    HorizontalProductsList("Category-ten"),
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
