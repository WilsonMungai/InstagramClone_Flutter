import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  // user name global variable
  String username = "";
  // runs at start of application
  // init state cant be async, therefore we need to creat an async func that will be called
  @override
  void initState() {
    super.initState();
    // async call to get user name
    getUserName();
  }

  // get data from firestore
  void getUserName() async {
    // get user from users collection with the current uid
    // returns a one time view of the document, creating a document snapshot, that is a future
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    // returns data of the logged in user
    setState(() {
      // map the data object to a string
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
    // print(snap.data());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('$username')));
  }
}
