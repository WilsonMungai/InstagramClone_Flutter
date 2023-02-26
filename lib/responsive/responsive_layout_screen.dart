import 'package:flutter/material.dart';
import 'package:isntagram/utils/dimensions.dart';

// Responseible for layout responsivenesss
class ResponsiveLayout extends StatelessWidget {
  // layout widgets
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout(
      {Key? key,
      // passs the properties to the widget
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        // constraints gives the contraints for the app
        builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        // return webScreenLayout when screen is > 600
        return webScreenLayout;
      }
      // mobile layout
      return mobileScreenLayout;
    });
  }
}
