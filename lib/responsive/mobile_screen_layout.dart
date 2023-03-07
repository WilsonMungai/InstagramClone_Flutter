import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:isntagram/providers/user_provider.dart';
import 'package:isntagram/models/user.dart' as model;
import 'package:provider/provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    // get user from provider
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(body: Center(child: Text(user.username)));
  }
}
