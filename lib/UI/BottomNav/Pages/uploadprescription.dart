import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';
import 'package:medishop/UI/BottomNav/bottomnavcontroller.dart';
import 'package:medishop/UI/CustomWidgets/custombutton.dart';
import 'package:medishop/UI/CustomWidgets/textboxtitle.dart';
import 'package:medishop/logic/login.dart';
import 'package:medishop/logic/uploadprescriptiondata.dart';
import 'package:provider/provider.dart';

class UploadPrescription extends StatefulWidget {
  @override
  _UploadPrescriptionState createState() => _UploadPrescriptionState();
}

class _UploadPrescriptionState extends State<UploadPrescription> {
  //  Sizebox height
  double sizeboxheightvalue = SizeConfig.screenwidth * 0.015;
  final _formkey = GlobalKey<FormState>();

  // tex editing controller
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController latloncontroller = TextEditingController();

  File imageone;
  File imagetwo;

  var urlcameraimage;
  var urlgalleryimage;
  Future ChooseFromCameraOne() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageone = pickedFile;
    });

    Navigator.of(context).pop();
    _uploadImageToFirebaseforcamera(pickedFile);
  }
  Future<void> _uploadImageToFirebaseforcamera(File image) async {
    try {

      // Upload image to firebase.
      final StorageReference postimageref = FirebaseStorage.instance.ref().child("uploaded-prescription");
      var timekey= DateTime.now();
      final StorageUploadTask uploadTask = postimageref.child(timekey.toString()+".jpg").putFile(image);
      var imageurl =await(await uploadTask.onComplete).ref.getDownloadURL();
      urlcameraimage=imageurl.toString();
      print(urlcameraimage);

    } catch (e) {
      print(e.message);
    }
  }
  Future ChooseFromGalleryOne() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageone = pickedFile;
    });
    Navigator.of(context).pop();
    _uploadImageToFirebaseGallery(pickedFile);
  }
  Future<void> _uploadImageToFirebaseGallery(File image) async {
    try {

      // Upload image to firebase.
      final StorageReference postimageref = FirebaseStorage.instance.ref().child("uploaded-prescription");
      var timekey= DateTime.now();
      final StorageUploadTask uploadTask = postimageref.child(timekey.toString()+".jpg").putFile(image);
      var imageurl =await(await uploadTask.onComplete).ref.getDownloadURL();
      urlgalleryimage=imageurl.toString();
      print(urlgalleryimage);

    } catch (e) {
      print(e.message);
    }
  }
  var urlcameraimagetwo;
  var urlgalleryimagetwo;
  Future ChooseFromCameraTwo() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imagetwo = pickedFile;
    });
    Navigator.of(context).pop();
    _uploadImageToFirebaseforcameratwo(pickedFile);
  }
  Future<void> _uploadImageToFirebaseforcameratwo(File image) async {
    try {

      // Upload image to firebase.
      final StorageReference postimageref = FirebaseStorage.instance.ref().child("uploadprescriptionimage");
      var timekey= DateTime.now();
      final StorageUploadTask uploadTask = postimageref.child(timekey.toString()+".jpg").putFile(image);
      var imageurl =await(await uploadTask.onComplete).ref.getDownloadURL();
      urlcameraimagetwo=imageurl.toString();
      print(urlcameraimagetwo);

    } catch (e) {
      print(e.message);
    }
  }
  Future ChooseFromGalleryTwo() async {
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imagetwo = pickedFile;
    });
    Navigator.of(context).pop();
    _uploadImageToFirebaseGallerytwo(pickedFile);
  }
  Future<void> _uploadImageToFirebaseGallerytwo(File image) async {
    try {

      // Upload image to firebase.
      final StorageReference postimageref = FirebaseStorage.instance.ref().child("uploadprescriptionimage");
      var timekey= DateTime.now();
      final StorageUploadTask uploadTask = postimageref.child(timekey.toString()+".jpg").putFile(image);
      var imageurl =await(await uploadTask.onComplete).ref.getDownloadURL();
      urlgalleryimagetwo=imageurl.toString();
      print(urlgalleryimagetwo);

    } catch (e) {
      print(e.message);
    }
  }
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

@override
  void initState() {
    getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final providerdataforprescription = Provider.of<UploadPrescriptionData>(context);
    final providerdata = Provider.of<UserLogin>(context);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(SizeConfig.screenwidth * 0.03),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: SizeConfig.screenwidth * 0.04,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Upload Prescription",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: SizeConfig.screenwidth * 0.07),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenwidth * 0.01,
              ),
              Text(
                "দয়া করে সতর্কতার সাথে আপনার তথ্য গুলো পূরণ করুন। আমরা আপনার তথ্য গুলা অন্য কারো সাথে শেয়ার করবো না।",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: SizeConfig.screenwidth * 0.032),
              ),
              SizedBox(
                height: SizeConfig.screenwidth * 0.07,
              ),
              TitleText("Choose Prescription Images"),
              SizedBox(
                height: sizeboxheightvalue,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: SizeConfig.screenheight / 4,
                    width: SizeConfig.screenwidth / 2.4,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: imageone == null
                        ? Center(
                            child: IconButton(
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                  size: SizeConfig.screenwidth * 0.1,
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          color: Colors.black45,
                                          height: SizeConfig.screenheight / 4,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Card(
                                                    child: ListTile(
                                                      title: Text("Camera"),
                                                      leading:
                                                          Icon(Icons.camera),
                                                      onTap: () {
                                                        ChooseFromCameraOne();
                                                      },
                                                    ),
                                                    elevation: 6,
                                                  ),
                                                  Card(
                                                    child: ListTile(
                                                      title: Text("Gallery"),
                                                      leading: Icon(
                                                          Icons.photo_library),
                                                      onTap: () {
                                                        ChooseFromGalleryOne();
                                                      },
                                                    ),
                                                    elevation: 6,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }),
                          )
                        : Image.file(
                            imageone,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Container(
                    height: SizeConfig.screenheight / 4,
                    width: SizeConfig.screenwidth / 2.4,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child: imagetwo == null
                        ? Center(
                            child: IconButton(
                                icon: Icon(
                                  Icons.add_circle,
                                  color: Colors.green,
                                  size: SizeConfig.screenwidth * 0.1,
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          color: Colors.black45,
                                          height: SizeConfig.screenheight / 4,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Card(
                                                    child: ListTile(
                                                      title: Text("Camera"),
                                                      leading:
                                                          Icon(Icons.camera),
                                                      onTap: () {
                                                        ChooseFromCameraTwo();
                                                      },
                                                    ),
                                                    elevation: 6,
                                                  ),
                                                  Card(
                                                    child: ListTile(
                                                      title: Text("Gallery"),
                                                      leading: Icon(
                                                          Icons.photo_library),
                                                      onTap: () {
                                                        ChooseFromGalleryTwo();
                                                      },
                                                    ),
                                                    elevation: 6,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }),
                          )
                        : Image.file(
                            imagetwo,
                            fit: BoxFit.cover,
                          ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.screenwidth * 0.05,
              ),
              TitleText("Enter your name"),
              SizedBox(
                height: sizeboxheightvalue,
              ),

              // text field started

              Form(
                key: _formkey,
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: SizeConfig.screenheight / 15,
                    width: SizeConfig.screenwidth,
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.screenwidth * 0.03,
                          right: SizeConfig.screenwidth * 0.03),
                      child: TextFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return "Enter Your Full Name";
                          }
                        },
                        controller: namecontroller,
                        style: TextStyle(
                          fontFamily: "Segoe UI",
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.screenwidth * 0.045,
                          color: Color(0xff000000),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.screenwidth * 0.045,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizeboxheightvalue,
                  ),
                  TitleText("Enter phone number"),
                  SizedBox(
                    height: sizeboxheightvalue,
                  ),
                  Container(
                    height: SizeConfig.screenheight / 15,
                    width: SizeConfig.screenwidth,
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.screenwidth * 0.03,
                          right: SizeConfig.screenwidth * 0.03),
                      child: TextFormField(
                        validator: (value){
                          if(value.length<11){
                            return "Enter Correct Number";
                          }
                        },
                        controller: phonenumbercontroller,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontFamily: "Segoe UI",
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.screenwidth * 0.045,
                          color: Color(0xff000000),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.screenwidth * 0.045,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sizeboxheightvalue,
                  ),
                  TitleText("Select or enter your area"),
                  SizedBox(
                    height: sizeboxheightvalue,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: SizeConfig.screenheight / 15,
                        width: SizeConfig.screenwidth / 1.5,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.screenwidth * 0.03,
                              right: SizeConfig.screenwidth * 0.03),
                          child: TextFormField(
                            controller: locationcontroller,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                              fontFamily: "Segoe UI",
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.screenwidth * 0.045,
                              color: Color(0xff000000),
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontFamily: "Segoe UI",
                                fontWeight: FontWeight.w600,
                                fontSize: SizeConfig.screenwidth * 0.045,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: SizeConfig.screenheight / 20,
                        width: SizeConfig.screenwidth * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Material(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.green,
                          child: InkWell(
                            onTap: () {
                              getUserLocation();
                            },
                            splashColor: Colors.red,
                            child: Center(
                              child: Text(
                                "Select",
                                style: TextStyle(
                                    color: Colors.white,
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
                    height: sizeboxheightvalue,
                  ),
                  TitleText("Latitude & Longitude"),
                  SizedBox(
                    height: sizeboxheightvalue,
                  ),
                  Container(
                    height: SizeConfig.screenheight / 15,
                    width: SizeConfig.screenwidth / 1.5,
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.green)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.screenwidth * 0.03,
                          right: SizeConfig.screenwidth * 0.03),
                      child: TextFormField(
                        validator: (value){
                          if(value.isEmpty){
                            return "Click On Select Button";
                          }
                        },
                        controller: latloncontroller,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontFamily: "Segoe UI",
                          fontWeight: FontWeight.w600,
                          fontSize: SizeConfig.screenwidth * 0.045,
                          color: Color(0xff000000),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: "Segoe UI",
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.screenwidth * 0.045,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ),


              // textfield finish


              SizedBox(
                height: SizeConfig.screenwidth * 0.15,
              ),
              CustomButton("Continue", () {

                if(_formkey.currentState.validate()){

                 providerdataforprescription.savePrescriptiontodatabase(urlcameraimage, urlgalleryimage, urlcameraimagetwo, urlgalleryimagetwo, namecontroller, locationcontroller, latloncontroller, phonenumbercontroller, providerdata.userid);
                  showDialog(context:context,
                    barrierDismissible: false,
                    builder: (context){
                    return AlertDialog(
                      title: Text("Uploadded Successfully !"),
                      content: Text("We will call you as quick as possible to confirm the order."),
                      actions: <Widget>[
                        RaisedButton(onPressed: (){
                          Navigator.pop(context);
                          Navigator.push(context, CupertinoPageRoute(builder: (context)=>BottomNavController()));
                        },child: Text("Ok"),)
                      ],
                    );
                    }
                  );
                }

              })
            ],
          ),
        ),
      )),
    );
  }
}
