import 'package:flutter/material.dart';
import 'package:netflix_clone_practice/model/firebase_provider.dart';
import 'package:netflix_clone_practice/screen/charity_screen.dart';
import 'package:netflix_clone_practice/screen/home_screen.dart';
import 'package:netflix_clone_practice/screen/login_screen.dart';
import 'package:netflix_clone_practice/screen/more_screen.dart';
import 'package:netflix_clone_practice/screen/search_screen.dart';
import 'package:netflix_clone_practice/widget/bottom_bar.dart';
import 'package:provider/provider.dart';

_TabScreenState pageState;

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() {
    pageState = _TabScreenState();
    return pageState;
  }
}

class _TabScreenState extends State<TabScreen> {
  // FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    // fp = Provider.of<FirebaseProvider>(context);

    return DefaultTabController(
        length: 5,
        child: Scaffold(
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeScreen(),
              SearchScreen(),
              Container(
                child: Center(
                  child: Text('check'),
                ),
              ),
              CharityScreen(),
              MoreScreen(),
            ],
          ),
          bottomNavigationBar: Bottom(),
        ));
  }
}
