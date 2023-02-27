import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isntagram/responsive/mobile_screen_layout.dart';
import 'package:isntagram/responsive/responsive_layout_screen.dart';
import 'package:isntagram/responsive/web_screen_layout.dart';
import 'package:isntagram/utils/colors.dart';

void main() async {
  // initialize widgets before initializing firebase
  WidgetsFlutterBinding.ensureInitialized();
  // check whether the app is running on web
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCH0SgpfECQ-YWeDWnoDgjMo0_1r28_aiY",
        appId: "1:881923422061:web:91bf175c2bb5dc59fd0c64",
        messagingSenderId: "881923422061",
        projectId: "instagram-flutter-7b2f6",
        storageBucket: "instagram-flutter-7b2f6.appspot.com",
      ),
    );
  } else {
// initialize firebase for ios & android
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram',
      // app theme
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      home: const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout()),
    );
  }
}
