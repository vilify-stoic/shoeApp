import 'package:ecommerce/constant.dart';
import 'package:ecommerce/custwidget.dart/bottomtab.dart';
import 'package:ecommerce/tabs.dart/Search_Tab.dart';
import 'package:ecommerce/tabs.dart/home_tab.dart';
import 'package:ecommerce/tabs.dart/saved_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabpageController;
  int _selectedtab;

  @override
  void initState() {
    _tabpageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabpageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PageView(
                controller: _tabpageController,
                onPageChanged: (num) {
                  setState(() {
                    _selectedtab = num;
                  });
                },
                children: [
                  HomeTab(),
                  SearchTab(),
                  SavedTab(),
                ],
              ),
            ),
            BottomTabs(
              selectedTab: _selectedtab,
              tabPressed: (num) {
                setState(() {
                  _selectedtab = num;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
