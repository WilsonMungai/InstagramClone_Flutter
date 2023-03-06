import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

// responsible for stroing files in firestore
class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // add image to firebase storage
  // responsible for stroing files in firestore - profile picture & posts
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // refernece to the storage with child paths to different folders
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    // upload the data to the storage
    UploadTask uploadTask = ref.putData(file);
    await uploadTask;
    // return the path to the uploaded file
    TaskSnapshot snap = await uploadTask;
    // gets download URL for the uploaded file
    String downloadURL = await snap.ref.getDownloadURL();
    // return the path to the downloaded file
    return downloadURL;
  }
}
