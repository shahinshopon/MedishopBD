import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:medishop/ResponsiveDesign/sizeconfig.dart';
import 'package:medishop/UI/LoginScreen/loginpage.dart';
import 'package:medishop/UI/allstring.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {

  @override
  void initState() {

    super.initState();
  }
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset(assetName, width: SizeConfig.screenwidth/1.5),
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: IntroductionScreen(
            globalBackgroundColor: Colors.transparent,

            key: introKey,
            pages: [
              PageViewModel(
                title: "আপলোড প্রেসক্রিপশন",
                body:
                AllString.uploaddescription,
                image: _buildImage("images/uploadprescription.jpg"),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "হোম ডেলিভারী",
                body:
                AllString.homedelivery,
                image: _buildImage('images/homedelivery.jpg'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "অফার",
                body:
                AllString.offer,
                image: _buildImage('images/offer.jpg'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "মেডিসিন কালেকশন",
                body: AllString.medicinecollection,
                image: _buildImage('images/medicines.png'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "ক্যাশ অন ডেলিভারি",
                body: AllString.cashondelivery,
                image: _buildImage('images/cashondelivery.png'),
                decoration: pageDecoration,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            skip: const Text('Skip'),
            next: const Icon(Icons.arrow_forward),
            done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
