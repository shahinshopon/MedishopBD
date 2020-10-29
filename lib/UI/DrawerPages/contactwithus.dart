import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';
import 'package:medishop/UI/CustomWidgets/custombutton.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWithUs extends StatefulWidget {
  @override
  _ContactWithUsState createState() => _ContactWithUsState();
}

class _ContactWithUsState extends State<ContactWithUs> {
  DocumentSnapshot number;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(flex: 1, child: Container()),
            Expanded(
                flex: 5,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Contact With Us",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: SizeConfig.screenwidth * 0.07),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenwidth * 0.02,
                        ),
                        Text(
                          "মেডিশপবিডি এপ্লিকেশন নিয়ে যেকোনো সমস্যার সম্মুখীন হলে এখনি আমাদের সাথে যোগাযোগ করতে পারেন।",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: SizeConfig.screenwidth * 0.032),
                        ),
                        SizedBox(
                          height: SizeConfig.screenwidth * 0.1,
                        ),
                        Text(
                          "Mobile Number",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.screenwidth * 0.034),
                        ),
                        Divider(),
                        Container(
                          height: SizeConfig.screenheight * 0.065,
                          width: SizeConfig.screenwidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              border: Border.all(color: Colors.green)),
                          child: Center(
                            child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection('contact-support')
                                    .document("0")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  var userDocument = snapshot.data;
                                  number=userDocument;
                                  return userDocument == null
                                      ? Text("")
                                      : Text(
                                    userDocument["number"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeConfig.screenwidth *
                                            0.060,
                                        color: Colors.pink),
                                  );
                                }),
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenwidth * 0.05,
                        ),
                        Text(
                          "Email Address",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: SizeConfig.screenwidth * 0.034),
                        ),
                        Divider(),
                        Container(
                          height: SizeConfig.screenheight * 0.065,
                          width: SizeConfig.screenwidth,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              border: Border.all(color: Colors.green)),
                          child: Center(
                            child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection('contact-support')
                                    .document("1")
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  var userDocument = snapshot.data;
                                  number=userDocument;
                                  return userDocument == null
                                      ? Text("")
                                      : Text(
                                    userDocument["email"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeConfig.screenwidth *
                                            0.060,
                                        color: Colors.pink),
                                  );
                                }),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: CustomButton("Call Now", () {
                              launch("tel://${number['number'].toString()}");
                            }),
                          ),
                        ),

                      ],
                    ),
                  ),
                )),

          ],
        ),
      ),
    );
  }
}
