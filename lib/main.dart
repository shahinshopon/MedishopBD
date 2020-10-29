import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medishop/UI/SplashScreen/splash.dart';
import 'package:medishop/logic/login.dart';
import 'package:medishop/logic/uploadprescriptiondata.dart';
import 'package:provider/provider.dart';
import 'logic/uploadmedicinerequest.dart';

void main() {
  runApp(
    MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => UserLogin()),
        ChangeNotifierProvider(create: (_) => UploadPrescriptionData()),
        ChangeNotifierProvider(create: (_) => UploadMedicineRequest()),
      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediShop BD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}
