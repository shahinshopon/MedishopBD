import 'package:flutter/material.dart';
import 'package:medishop/UI/CustomWidgets/appbartitle.dart';
import 'package:medishop/UI/CustomWidgets/productgridlist.dart';

class CategoryNine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: AppBarTitle(context,"8"),
      ),
      body: ProductGridList("Category-nine"),
    );
  }
}
