import 'dart:ui';

import 'package:chairs/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MovieDetail extends StatefulWidget {
  String title, content, moviet, image, mid;
  int numberofchairs; //,image
  MovieDetail(
      {this.title,
      this.content,
      this.moviet,
      this.image,
      this.mid,
      this.numberofchairs});

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  FirebaseAuth a = FirebaseAuth.instance;
  GlobalKey colorkey;
  Widget build(BuildContext context) {
    var width1 = MediaQuery.of(context).size.width;
    MovieDetail mo = ModalRoute.of(context).settings.arguments;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Color.fromRGBO(0, 81, 93, 1),
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.amber[100],
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: (mo.image == null)
                                    ? AssetImage('assets/images/a3.png')
                                    : NetworkImage(mo.image),
                              )),
                        ),
                      ),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                mo.title,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              mo.moviet,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.red[300],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(217, 154, 140, 0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromRGBO(155, 155, 155, 0.5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Text(
                                    mo.content,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ],
                              ),
                            ),
                          )),
//////////////////////////  chairs part/////////////
/////////////////////////
///////////////////224444
//////////////////////////////////

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.green,
                                ),
                                height: 20,
                                width: 20,
                                child: Text(''),
                              ),
                              Text('  Valid  '),
                            ],
                          ),
                          /////////////////
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.red,
                                ),
                                height: 20,
                                width: 20,
                                child: Text(''),
                              ),
                              Text('  Unvalid  '),
                            ],
                          ),
                          /////////////////
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue,
                                ),
                                height: 20,
                                width: 20,
                                child: Text(''),
                              ),
                              Text('  Your Chairs'),
                            ],
                          ),
                          /////////////////
                          SizedBox(
                            width: 1,
                            height: 100,
                          )
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Film')
                              .doc(mo.mid)
                              .collection('chairs')
                              .orderBy('id')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('your error is ${snapshot.error}');
                            }
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 7),
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(500)),
                                    child: SizedBox(
                                      width: 30,
                                      child: RaisedButton(
                                        child: Text('$index'),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        key: colorkey,
                                        color: snapshot.data.docs[index]
                                                    .data()['state'] ==
                                                'null'
                                            ? Colors.green
                                            : snapshot.data.docs[index]
                                                        .data()['state'] ==
                                                    a.currentUser.uid
                                                ? Colors.blue
                                                : Colors.red,
                                        onPressed: () {
                                          setState(() {
                                            String state = snapshot
                                                .data.docs[index]
                                                .data()['state'];
                                            if (state == 'null') {
                                              FirebaseFirestore.instance
                                                  .collection('Film')
                                                  .doc(mo.mid)
                                                  .collection('chairs')
                                                  .doc('${index}')
                                                  .set({
                                                'state': a.currentUser.uid,
                                                'id': index,
                                              });
                                              FirebaseFirestore.instance
                                                  .collection('Notifications')
                                                  .doc()
                                                  .set({
                                                'user_email':
                                                    a.currentUser.email,
                                              });
                                              FirebaseFirestore.instance
                                                  .collection('Film')
                                                  .doc(mo.mid)
                                                  .update({
                                                'numberofchairs':
                                                    mo.numberofchairs - 1
                                              });
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'chair number $index in your own',
                                                  backgroundColor: Colors.black,
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM);

////////////////////////////////make Notifications
                                              var ref = FirebaseFirestore
                                                  .instance
                                                  .collection('Notifications')
                                                  .doc();

                                              ref.set({
                                                'user_email':
                                                    a.currentUser.email,
                                                'movie_title': mo.title,
                                                'number_of_chair': index,
                                                'state': 'booking',
                                                'image': mo.image,
                                                'id': ref.id,
                                              });

////////////////////////////
                                            } else {
                                              if (state == a.currentUser.uid) {
                                                FirebaseFirestore.instance
                                                    .collection('Film')
                                                    .doc(mo.mid)
                                                    .collection('chairs')
                                                    .doc('${index}')
                                                    .set({
                                                  'state': 'null',
                                                  'id': index,
                                                });
                                                FirebaseFirestore.instance
                                                    .collection('Film')
                                                    .doc(mo.mid)
                                                    .update({
                                                  'numberofchairs':
                                                      mo.numberofchairs + 1
                                                });
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'chair number $index canceled',
                                                    backgroundColor: Colors.red,
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM);
                                                ////////////////////////////////make Notifications
                                                var ref = FirebaseFirestore
                                                    .instance
                                                    .collection('Notifications')
                                                    .doc();
                                                ref.set({
                                                  'user_email':
                                                      a.currentUser.email,
                                                  'movie_title': mo.title,
                                                  'number_of_chair': index,
                                                  'state': 'canceled',
                                                  'image': mo.image,
                                                  'id': ref.id,
                                                });
////////////////////////////
                                              }
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                          width: width1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width1 / 3,
                                      height: 50,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.green,
                                        ),
                                        child: Text(
                                          ' valed chairs = ${mo.numberofchairs}',
                                          style: TextStyle(fontSize: 20),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width1 / 3,
                                      height: 50,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red,
                                        ),
                                        child: Text(
                                            ' unvaled chairs = ${47 - mo.numberofchairs}',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                    ]),

////////////////////////////////////
///////////////////////////////////
                    ///
                  ],
                ))));
  }
}
