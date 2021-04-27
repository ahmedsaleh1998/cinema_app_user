import 'dart:ui';
import 'package:chairs/main.dart';
import 'package:chairs/pages/movie_detail.dart';
import 'package:chairs/pages/sign_and_login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MovieMain extends StatefulWidget {
  @override
  _MovieMainState createState() => _MovieMainState();
}

class _MovieMainState extends State<MovieMain> {
  FirebaseAuth instance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    GlobalKey skafol = GlobalKey<ScaffoldState>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(0, 73, 83, 1.0)),
                  child: Column(
                    children: [
                      Container(
                          width: 70,
                          height: 70,
                          child: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: Icon(
                              Icons.perm_identity_outlined,
                              size: 70,
                            ),
                          )),
                      Text(instance.currentUser.email),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('logout'),
                  onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('You Want To logout?'),
                        actions: [
                          RaisedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text('NO'),
                          ),
                          RaisedButton(
                            onPressed: () async {
                              await instance.signOut();
                              setState(() {
                                Navigator.popAndPushNamed(context, '/');
                              });
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
/////////////////////////////
                    },
                  ),
                )
              ],
            ),
          ),
          key: skafol,
          backgroundColor: Color.fromRGBO(0, 73, 83, 1.0),
          appBar: AppBar(
            title: Text('Movies'),
            centerTitle: true,
            backgroundColor: Color.fromRGBO(16, 42, 48, 0),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('You Want To logout?'),
                            actions: [
                              RaisedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('NO'),
                              ),
                              RaisedButton(
                                onPressed: () async {
                                  await instance.signOut();
                                  setState(() {
                                    Navigator.popAndPushNamed(context, '/');
                                  });
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        });
                  })
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/cinema-app-247f8.appspot.com/o/image_picker2631741982909539820.jpg?alt=media&token=8baf6b1a-7f47-4c21-9f59-2486fd8ffb87'),
                      fit: BoxFit.fill)),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Film')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1),
                          itemCount:
                              snapshot.hasData ? snapshot.data.docs.length : 0,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetail(),
                                  settings: RouteSettings(
                                    arguments: MovieDetail(
                                      title: snapshot.data.docs[index]
                                          .data()['title'],
                                      content: snapshot.data.docs[index]
                                          .data()['description'],
                                      moviet: snapshot.data.docs[index]
                                          .data()['time'],
                                      image: snapshot.data.docs[index]
                                          .data()['movie_image'],
                                      mid: snapshot.data.docs[index]
                                          .data()['id'],
                                      numberofchairs: snapshot.data.docs[index]
                                          .data()['numberofchairs'],
                                    ),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.amber[100],
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: (snapshot.data.docs[index]
                                                    .data()["movie_image"] ==
                                                null)
                                            ? AssetImage('assets/images/a3.png')
                                            : NetworkImage(snapshot
                                                .data.docs[index]
                                                .data()["movie_image"]),
                                      )),
                                  margin: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      // Image(
                                      //   image: (snapshot.data.docs[index]
                                      //               .data()["image"] ==
                                      //           null)
                                      //       ? AssetImage('assets/images/a3.png')
                                      //       : NetworkImage(snapshot.data.docs[index]
                                      //           .data()["image"]),
                                      //   fit: BoxFit.fill,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
              ))),
    );
  }
}
