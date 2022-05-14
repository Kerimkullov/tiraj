import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tiraj/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), (() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/images/logo.png')),
    );
  }
}
