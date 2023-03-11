import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profileImage;
  final likes;

  // constructors
  const Post({
    required this.description,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
  });

  // convert to json objects
  Map<String, dynamic> toJson() => {
        "description": description,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        "postUrl": postUrl,
        "profileImage": profileImage,
        "likes": likes,
      };

  // convert document snapshot to user model
  static Post fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    // taking a doc snapshot and converting to user model
    return Post(
      description: snapShot['description'],
      uid: snapShot['uid'],
      username: snapShot['username'],
      postId: snapShot['postId'],
      datePublished: snapShot['datePublished'],
      postUrl: snapShot['postUrl'],
      profileImage: snapShot['profileImage'],
      likes: snapShot['likes'],
    );
  }
}
