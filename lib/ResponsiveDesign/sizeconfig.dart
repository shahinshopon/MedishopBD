import 'package:flutter/cupertino.dart';

class SizeConfig{
  MediaQueryData mediaQueryData;
  static double screenheight;
  static double screenwidth;
  void init(BuildContext context){
    mediaQueryData=MediaQuery.of(context);
    screenheight=mediaQueryData.size.height;
    screenwidth=mediaQueryData.size.width;
  }
}