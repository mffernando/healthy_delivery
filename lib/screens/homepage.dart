import 'package:flutter/material.dart';
import 'package:healthy_delivery/tabs/hometab.dart';
import 'package:healthy_delivery/tabs/savedtab.dart';
import 'package:healthy_delivery/tabs/searchtab.dart';
import 'package:healthy_delivery/widgets/custombottomtabs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //control the tabs and pages
  late PageController _tabsPageController;
  //selected tab
  int _selectedTab = 0;

  //initialize _tabsPageController
  @override
  void initState() {
    //print("User ID: ${_firebaseServices.getUserId()}");
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageController, //control page
              onPageChanged: (page) {
                setState(() {
                  _selectedTab = page;
                  //print("Selected tab: $_selectedTab");
                });
              },
              children: [
                HomeTab(), //Home Tab
                SearchTab(), //Search Tab
                SavedTab(), //SavedTab
              ],
            ),
          ),
          CustomBottomTabs(
            //select tab
            selectedTab: _selectedTab,
            //go to pressed tab
            pressedTab: (page) {
              _tabsPageController.animateToPage(
                  page,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic
              );
            },
          ),
        ],
      ),
    );
  }
}
