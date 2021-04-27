import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class sign_and_login extends StatefulWidget {
  @override
  _sign_and_loginState createState() => _sign_and_loginState();
}

class _sign_and_loginState extends State<sign_and_login> {
  @override
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    instance.authStateChanges().listen((User user) {
      if (user == null) {
        Navigator.pushNamed(context, 'sign_and_login');
      } else {
        Navigator.popAndPushNamed(context, 'mainmovie');
      }
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 10,
                    height: 30,
                  ),
                  Text(
                    'welcome',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
                height: 30,
              ),
              Container(
                child: Image.asset('assets/images/a1.png'),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: RaisedButton(
                        disabledColor: Colors.red[200],
                        color: Colors.red[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, 'login');
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                      height: 20,
                    ),
                    SizedBox(
                        width: 300,
                        height: 60,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () {
                            Navigator.popAndPushNamed(context, 'signup');
                          },
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
