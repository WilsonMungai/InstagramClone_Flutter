import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String uid;
  final String email;
  final String bio;
  final String photoURL;
  final List followers;
  final List following;

  // constructors
  const User({
    required this.username,
    required this.uid,
    required this.email,
    required this.bio,
    required this.photoURL,
    required this.followers,
    required this.following,
  });

  // convert to json objects
  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "bio": bio,
        "photoURL": photoURL,
        "followers": followers,
        "following": following,
      };

  // convert document snapshot to user model
  static User fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    // taking a doc snapshot and converting to user model
    return User(
      username: snapShot['username'],
      uid: snapShot['uid'],
      email: snapShot['email'],
      bio: snapShot['bio'],
      photoURL: snapShot['photoURL'],
      followers: snapShot['followers'],
      following: snapShot['following'],
    );
  }
}
