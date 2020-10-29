import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';
import 'package:medishop/UI/LoginScreen/loginpage.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var name;
  var phone;


  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  // global key
  final _key = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = Firestore.instance;

  // registration function
  signup (String name,phone,email,password)async{
    final FirebaseUser user = (await
    _auth.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    )
    ).user;
    if (user != null) {
       db.collection("users").add({
         'name':name,
         'phone':phone,
         'email':_email.text,
         'password':_password.text,
         'UID':user.uid,
       });
       Navigator.push(context, CupertinoPageRoute(builder: (context)=>LoginScreen(),),);
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.green));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: SizeConfig.screenheight/6,
                    width: SizeConfig.screenwidth,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(SizeConfig.screenheight*0.2))
                    ),
                    child: Center(
                      child: Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: SizeConfig.screenheight*0.05),),
                    ),
                  ),

                  // Form Widget
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.screenwidth * 0.05),
                    child: Form(
                      key: _key,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.text,
                            validator: (value){
                              if(value.isEmpty){
                                return "Enter Your Full Name";
                              }
                            },
                            onChanged: (val){
                              setState(() {
                                name=val;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Full Name",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(

                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(

                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenheight*0.02,),
                          TextFormField(

                            validator: (value){
                              if(value.isEmpty){
                                return "Enter Your Phone Number";
                              }
                            },
                            onChanged: (val){
                              setState(() {
                                phone=val;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: "Phone Number",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(

                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(

                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: SizeConfig.screenheight*0.02,),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if(value.isEmpty){
                                return "Enter Your Email";
                              }
                            },
                            controller: _email,
                            decoration: InputDecoration(
                              labelText: "Email Address",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(

                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(

                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.screenheight*0.02,),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value){
                              if(value.length<6){
                                return "Passwod atlest 6 digit";
                              }
                            },
                            controller: _password,
                            decoration: InputDecoration(
                              labelText: "Password",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(

                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(

                                borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Text Span
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.screenwidth * 0.05),

                    child: Align(
                      alignment: Alignment.centerRight,
                      child: RichText(text: TextSpan(
                          text: "Already have an account ? ",style: TextStyle(color: Colors.black),
                          children: [

                            TextSpan(

                                text: "LOGIN",style: TextStyle(color: Colors.green,fontSize: SizeConfig.screenheight*0.02,fontWeight: FontWeight.w600),
                                recognizer: TapGestureRecognizer()..onTap=()=>Navigator.push(context, CupertinoPageRoute(builder: (context)=>LoginScreen()))
                            )
                          ]
                      ),
                      ),
                    ),
                  ),

                  Divider(),
                  // button
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.screenwidth * 0.05),
                    child: Container(
                      height: SizeConfig.screenheight * 0.055,
                      width: SizeConfig.screenwidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.green,
                        child: InkWell(
                          onTap: () {
                            if(_key.currentState.validate()){
                              signup(name, phone, _email, _password);
                            }
                          },
                          splashColor: Colors.white,
                          child: Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.screenwidth * 0.04),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
