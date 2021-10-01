import 'package:flutter/material.dart';
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
                Container(
                  child: Center(
                    child: Text("HomePage"),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text("SearchPage"),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text("SavedPage"),
                  ),
                )
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
