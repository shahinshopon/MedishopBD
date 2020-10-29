import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';

Widget CustomButton(String centertext, Function onPressed){
  return  Container(
      height: SizeConfig.screenheight*0.055,
      width: SizeConfig.screenwidth,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Material(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.green,
          child: InkWell(
            onTap: onPressed,
            splashColor: Colors.white,
            child: Center(
              child: Text(
                centertext,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.screenwidth*0.04),
              ),
            ),
          )));
}