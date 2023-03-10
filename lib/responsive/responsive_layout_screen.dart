import 'package:flutter/material.dart';
import 'package:isntagram/utils/global_variables.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

// Responseible for layout responsivenesss
class ResponsiveLayout extends StatefulWidget {
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
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  // init state to call user provider
  @override
  void initState() {
    super.initState();
    addData();
  }

  // async call user provider
  void addData() async {
    // pass listen as false, to get one time listener
    // context is from the state
    UserProvider _userProvider = Provider.of(context, listen: false);
    // refresh provider
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        // constraints gives the contraints for the app
        builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        // return webScreenLayout when screen is > 600
        return widget.webScreenLayout;
      }
      // mobile layout
      return widget.mobileScreenLayout;
    });
  }
}
