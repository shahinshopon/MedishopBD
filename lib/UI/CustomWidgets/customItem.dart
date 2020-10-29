import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';

Widget CustomItem(double height, double width,icon,String title, Function onPressed, ){

  return  Container(
      height: height,
      width: width,
      decoration: BoxDecoration(

        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Material(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.green,
          child: InkWell(
            onTap: onPressed,
            splashColor: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(icon,color: Colors.white,size: 25,),
                  SizedBox(height: SizeConfig.screenwidth*0.01,),

                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.screenwidth*0.030),
                  ),
                ],
              ),
            ),
          )));
}