import 'package:firebase_auth/firebase_auth.dart';
import 'package:chairs/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  FirebaseAuth instance = FirebaseAuth.instance;
  GlobalKey skey = GlobalKey();
  String username, email, password;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: skey,
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
                    'SIGN UP ',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
                height: 15,
              ),
              Container(
                child: Image.asset('assets/images/a2.png'),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                        width: 300,
                        height: 60,
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              username = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'User Name',
                              prefixIcon: Icon(
                                Icons.supervised_user_circle_sharp,
                                color: Colors.blue,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        )),
                    SizedBox(
                      width: 10,
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: Icon(
                              Icons.email_sharp,
                              color: Colors.blue,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                      height: 20,
                    ),
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        obscuringCharacter: '*',
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.blue,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                      height: 20,
                    ),
                    SizedBox(
                        width: 300,
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 140,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                onPressed: () async {
                                  try {
                                    UserCredential credetional = await instance
                                        .createUserWithEmailAndPassword(
                                            email: email, password: password);
                                    Navigator.popAndPushNamed(
                                        context, 'mainmovie');
                                  } on FirebaseAuthException catch (e) {
                                    print(e);
                                  }
                                },
                                color: Color.fromRGBO(64, 123, 255, 0.4),
                                disabledColor:
                                    Color.fromRGBO(64, 123, 255, 0.4),
                                child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 140,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                disabledColor: Colors.black12,
                                onPressed: () {
                                  Navigator.pushNamed(context, 'login');
                                },
                                child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
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
