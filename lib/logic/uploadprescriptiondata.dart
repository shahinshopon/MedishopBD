import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class UploadPrescriptionData extends ChangeNotifier{

   savePrescriptiontodatabase(var urlcameraimage,urlgalleryimage,urlcameraimagetwo,urlgalleryimagetwo,
      TextEditingController namecontroller,locationcontroller,latloncontroller,phonenumbercontroller,
      String userid

      )async{
    var dbTimekey=new DateTime.now();
    var formatDate=new DateFormat('MMM d,yyyy');
    var formatTime=new DateFormat('EEEE hh:mm,aaa');

    String date=formatDate.format(dbTimekey);
    String time=formatTime.format(dbTimekey);

    Firestore.instance.collection("Order-By-Prescription").document(userid).collection("uploadedlist").add({
      "prescription-camere-img":urlcameraimage,
      "prescription-gallery-img":urlgalleryimage,
      "prescription-camere-img2":urlcameraimagetwo,
      "prescription-gallery-img2":urlgalleryimagetwo,
      "user-name":namecontroller.text,
      "user-address":locationcontroller.text,
      "user-lat&long":latloncontroller.text,
      "Phonenumber":phonenumbercontroller.text,
      "order-date":date,
      "order-Time":time
    });

    notifyListeners();
  }


}