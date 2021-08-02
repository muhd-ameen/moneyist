import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool loaded = false;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xFFFFFFFF),
        body:
        Stack(
          children: [
            // Positioned.fill(child: Image.asset('assets/images/unsplash.png',fit: BoxFit.fill,)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5
                  ,child: Container(),),
                Image.asset('assets/images/splash.png',height: 250,),
                Image.asset('assets/images/m-text.png',height: 60,),

                Expanded(
                  flex:5,child: Container(),),
                // Image.asset('assets/images/m-text.png',height: 60,),
                Expanded(
                  flex: 1,child: Container(),),

              ],
            )
          ],
        )
    );
  }

  startTime() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, () {
      navigationPage('/welcome');
    });
  }

  void navigationPage(String destination) {
    Navigator.of(context).pushReplacementNamed(destination);
  }

}