import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class main_home extends StatefulWidget {
  @override
  _main_homeState createState() => _main_homeState();
}

class _main_homeState extends State<main_home> {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.red[300],
        appBar: AppBar(
          title: Text('hi in elgoud comunity'),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await instance.signOut();
                }),
          ],
        ),
      ),
    );
  }
}
