import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  // instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // instance of firebase firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // sign up user
  // return type is future coz the calls to firebase are asynchronous
  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
    required String bio,
    // required Uint8List file
  }) async {
    String res = "Some error occured";
    try {
      // check fields are not empty
      if (email.isNotEmpty || password.isNotEmpty || bio.isNotEmpty) {
        // sign up user
        // await firebase auth
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);
        // add user to database
        // create user collection, with a uid and set it
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': username,
          'uid': cred.user!.uid,
          'email': email,
          'bio': bio,
          // a list of uid followers
          'followers': [],
          // a list of uid following
          'following': []
        });
        // this method returns two different uids
        // _firestore.collection('users').add({
        //   'username': username,
        //   'uid': cred.user!.uid,
        //   'email': email,
        //   'bio': bio,
        //   'followers': [],
        //   'following': []
        // });
        res = 'success';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
