import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:isntagram/models/user.dart' as model;
import 'package:isntagram/Resources/storage_methods.dart';

class AuthMethods {
  // instance of firebase auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // instance of firebase firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // methd to get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    // Document Snapshot
    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    // convert document snapshot to model
    return model.User.fromSnap(snap);
  }

  // sign up user
  // return type is future coz the calls to firebase are asynchronous
  Future<String> signUpUser(
      {required String username,
      required String email,
      required String password,
      required String bio,
      required Uint8List file}) async {
    String res = "Some error occured";
    try {
      // check fields are not empty
      if (email.isNotEmpty || password.isNotEmpty || bio.isNotEmpty) {
        // sign up user
        // await firebase auth
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        // ignore: avoid_print
        print(cred.user!.uid);
        String photoURL = await StorageMethods()
            .uploadImageToStorage('progilePics', file, false);
        // add user to database
        // create user collection, with a uid and set it

        // create user model
        model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            photoURL: photoURL,
            // a list of uid followers
            followers: [],
            // a list of uid following
            following: []);

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
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
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is not valid';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // user log in
  Future<String> logInUse({
    required String email,
    required String password,
  }) async {
    String res = "Please enter valid email and password";
    try {
      // check fields are not empty
      if (email.isNotEmpty || password.isNotEmpty) {
        // log in user
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter an email and password';
      }
    }
    // custom error handling
    on FirebaseAuthException catch (err) {
      if (err.code == 'The email address is badly formatted') {
        // show wrong email error message
        res = 'Please enter valid email and password';
      } else {
        // show wrong password error message
        res = 'Please enter valid email and password';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
