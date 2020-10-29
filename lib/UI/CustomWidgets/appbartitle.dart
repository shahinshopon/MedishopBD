import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget AppBarTitle(BuildContext context, String documentid) {

  return new StreamBuilder(
      stream: Firestore.instance
          .collection('Categories')
          .document(documentid)
          .snapshots(),
      builder: (context, snapshot) {
        var userDocument = snapshot.data;
        return userDocument == null
            ? Text("")
            : Text(
          userDocument["name"],
          style: TextStyle(

              color: Colors.white),
        );
      });
}