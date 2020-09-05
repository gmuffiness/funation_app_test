import 'package:flutter/material.dart';
import 'package:netflix_clone_practice/screen/home_screen.dart';
import 'package:netflix_clone_practice/screen/login_screen.dart';
import 'package:netflix_clone_practice/screen/more_screen.dart';
import 'package:netflix_clone_practice/screen/search_screen.dart';
import 'package:netflix_clone_practice/widget/bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<MyApp> {
  TabController controller;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '기부니가좋다',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Colors.black,
      ),
      home: DefaultTabController(
          length: 5,
          child: Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                HomeScreen(),
                SearchScreen(),
                Container(
                  child: Center(
                    child: Text('save'),
                  ),
                ),
                MoreScreen(),
                LoginScreen(),
              ],
            ),
            bottomNavigationBar: Bottom(),
          )),
    );
  }
}
