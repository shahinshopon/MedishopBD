import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';

Widget TitleText(String title){
  return Text(
    title,
    style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: SizeConfig.screenwidth * 0.035,
        color: Colors.blueGrey),
  );
}