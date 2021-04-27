import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:chairs/pages/login.dart';
import 'package:chairs/pages/sign_and_login.dart';
import 'package:chairs/pages/signup.dart';
import 'package:flutter/material.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedSplashScreen(
          splash: Image.asset('assets/images/0100.gif'),
          splashIconSize: 250,
          backgroundColor: Colors.white,
          nextScreen: sign_and_login()),
    );
  }
}
