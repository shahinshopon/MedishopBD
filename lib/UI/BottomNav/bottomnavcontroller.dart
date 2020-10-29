import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:medishop/UI/BottomNav/Pages/help.dart';
import 'package:medishop/UI/BottomNav/Pages/home.dart';
import 'package:medishop/UI/BottomNav/Pages/orderbycall.dart';
import 'package:medishop/UI/BottomNav/Pages/uploadprescription.dart';


class BottomNavController extends StatefulWidget {
  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  
  
  int index = 0;
  final _pages = [
    HomePage(),
    OrderByCallPage(),
    UploadPrescription(),
    HelpPage(),


  ];
  

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(

        bottomNavigationBar: CurvedNavigationBar(
          height: MediaQuery.of(context).size.height / 13,
          index: 0,
          color: Colors.pink,
          buttonBackgroundColor: Colors.pink,
          backgroundColor: Colors.white24,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 500),
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.phone_in_talk,
              color: Colors.white,
            ),
            Icon(
              Icons.add_circle,
              color: Colors.white,
            ),
            Icon(Icons.help,color: Colors.white,),

          ],
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
        ),
        body: _pages[index],
      ),
    );
  }
}
