import 'package:chairs/pages/login.dart';
import 'package:chairs/pages/main_home.dart';
import 'package:chairs/pages/movie_detail.dart';
import 'package:chairs/pages/movie_main.dart';
import 'package:chairs/pages/signup.dart';
import 'package:chairs/pages/splash.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'pages/sign_and_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(app());
}

class app extends StatefulWidget {
  @override
  _appState createState() => _appState();
}

class _appState extends State<app> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        'login': (context) => login(),
        'signup': (context) => signup(),
        '/': (context) => sign_and_login(),
        'main_home': (context) => main_home(),
        'splash1': (context) => splashscreen(),
        'mainmovie': (context) => MovieMain(),
        'mainmovie2': (context) => MovieDetail()
      },
    );
  }
}
