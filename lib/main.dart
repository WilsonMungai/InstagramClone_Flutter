import 'package:flutter/material.dart';
import 'package:isntagram/responsive/mobile_screen_layout.dart';
import 'package:isntagram/responsive/responsive_layout_screen.dart';
import 'package:isntagram/responsive/web_screen_layout.dart';
import 'package:isntagram/utils/colors.dart';

void main() {
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
