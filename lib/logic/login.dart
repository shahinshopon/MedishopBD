import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medishop/UI/BottomNav/bottomnavcontroller.dart';

class UserLogin extends ChangeNotifier{


  final FirebaseAuth _auth = FirebaseAuth.instance;
  var userid;

  login (email,password,context)async{

    try{
      final FirebaseUser user = (await
      _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      )).user;

      if (user != null) {
        userid=user.uid;

        Navigator.push(context, CupertinoPageRoute(builder: (context)=>BottomNavController(),),);
      }

    }catch(e){

      Fluttertoast.showToast(msg: "Not Verified",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);

    }

    notifyListeners();




    // Fluttertoast.showToast(msg: "Email is not varified",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.BOTTOM);
  }

}