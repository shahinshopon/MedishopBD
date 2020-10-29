import 'package:flutter/material.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';

Widget SeeAllTextWidget(Function onPressed) {
  return GestureDetector(
    child: Text(
      "See All",
      style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: SizeConfig.screenwidth * 0.044,
          color: Colors.red),
    ),
    onTap: onPressed,
  );
}
