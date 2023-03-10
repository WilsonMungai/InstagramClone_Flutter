import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isntagram/utils/colors.dart';

import '../utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  // page index
  int _page = 0;
  // manipulate which page is visible
  late PageController pageController;

  // initialize page controller state
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  // check page that is selected
  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  // track when page changes
  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  // list of pages
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        // list of widget matching bottom navigation bar items
        children: homeScreenItems,
        // disable scroll effect from page to page
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      // bottom navigation bar
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        // tab bar items
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _page == 1 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: _page == 2 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                color: _page == 3 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
