import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Screens/home_screen.dart';
import 'package:weather_app/Screens/login_screen.dart';

class Splash_Screen extends StatefulWidget{

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), (){
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
          (FirebaseAuth.instance.currentUser != null) ? Home() : LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff212F3C),
      body: Center(
        child: Image.asset("assets/cloud.png", height: 200, width: 200)
      ),
    );
  }
}