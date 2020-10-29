import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';
import 'package:medishop/UI/LoginScreen/registration.dart';
import 'package:medishop/logic/login.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  // global key
  final _key = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.green));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerdata = Provider.of<UserLogin>(context);
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
                      child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: SizeConfig.screenheight*0.05),),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenheight*0.1,),
                  // Form Widget
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.screenwidth * 0.05),
                    child: Form(
                      key: _key,
                      child: Column(
                        children: <Widget>[

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
                              if(value.length<5){
                                return "Enter Corrcet Password";
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
                    padding: EdgeInsets.only(left: SizeConfig.screenwidth * 0.05,right: SizeConfig.screenwidth * 0.05),


                    child: Align(
                      alignment: Alignment.centerRight,
                      child: RichText(text: TextSpan(
                        text: "Not registered yet ? ",style: TextStyle(color: Colors.black),
                        children: [

                          TextSpan(

                            text: "Create Account",style: TextStyle(color: Colors.green,fontSize: SizeConfig.screenheight*0.02,fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()..onTap=()=>Navigator.push(context, CupertinoPageRoute(builder: (context)=>RegistrationScreen()))
                          )
                        ]
                      ),
                      ),
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenheight*0.05,),
                  // button
                  Padding(
                    padding: EdgeInsets.only(left: SizeConfig.screenwidth * 0.05,right: SizeConfig.screenwidth * 0.05,),
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

                              providerdata.login(_email, _password, context);


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
