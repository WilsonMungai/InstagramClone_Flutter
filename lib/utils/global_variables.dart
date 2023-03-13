import 'package:flutter/material.dart';
import 'package:isntagram/Screens/add_post_screen.dart';

import '../Screens/feed_screen.dart';

// beyond this size the app will display as a web page
const webScreenSize = 600;

// screens
const homeScreenItems = [
  FeedScreen(),
  Text("search"),
  AddPostScreen(),
  Text("like"),
  Text("profile"),
];
