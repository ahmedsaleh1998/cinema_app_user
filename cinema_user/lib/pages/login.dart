import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  FirebaseAuth instance = FirebaseAuth.instance;

  String email, password;
  @override
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
                    'login',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
                height: 15,
              ),
              Container(
                child: Image.asset('assets/images/a3.png'),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                              color: Color.fromRGBO(255, 199, 39, 1),
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
                              color: Color.fromRGBO(255, 199, 39, 1),
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
                                    UserCredential cradental = await instance
                                        .signInWithEmailAndPassword(
                                            email: email, password: password);
                                    Navigator.popAndPushNamed(
                                        context, 'mainmovie');
                                  } on FirebaseAuthException catch (e) {
                                    print(e);
                                  }
                                },
                                disabledColor: Color.fromRGBO(255, 199, 39, 1),
                                color: Color.fromRGBO(255, 199, 39, 1),
                                child: Text(
                                  'Login',
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
                                  Navigator.pushNamed(context, 'signup');
                                },
                                child: Text(
                                  'Sign UP',
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
