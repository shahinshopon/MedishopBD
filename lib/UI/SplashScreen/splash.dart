import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medishop/UI/LoginScreen/loginpage.dart';
import 'package:medishop/UI/OnboardPages/onboardingcontrol.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => OnBoardingPage()));
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    new Timer(new Duration(seconds: 3), () {
      checkFirstSeen();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            height: SizeConfig.screenheight / 10,
            width: SizeConfig.screenwidth / 1.5,
            child: Image.asset(
              "images/splashlogo.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
