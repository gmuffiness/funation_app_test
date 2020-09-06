import 'package:flutter/material.dart';
import 'package:netflix_clone_practice/model/api_adapter.dart';
import 'package:netflix_clone_practice/model/firebase_provider.dart';
import 'package:netflix_clone_practice/model/movie_model.dart';
import 'package:netflix_clone_practice/screen/login_screen.dart';
import 'package:netflix_clone_practice/screen/more_screen.dart';
import 'package:netflix_clone_practice/screen/search_screen.dart';
import 'package:netflix_clone_practice/widget/bottom_bar.dart';
import 'package:netflix_clone_practice/widget/box_slider.dart';
import 'package:netflix_clone_practice/widget/circle_slider.dart';
import 'package:netflix_clone_practice/widget/carousel_slider.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [
    Movie.fromMap({
      'title': 'SmallAction',
      'body': '업사이클링으로 함께 환경을 살려요.',
      'thumbnail': 'smallaction.PNG',
      'target_amount': '6,000원 남음',
      'like': false,
    }),
    Movie.fromMap({
      'title': 'OrangeDried',
      'body': '맛있는 건어물',
      'thumbnail': 'content1.PNG',
      'target_amount': '6,000원 남음',
      'like': false,
    }),
    Movie.fromMap({
      'title': 'CharCoalPearl',
      'body': '숯진주연구소의 술잔/머들러/목걸이',
      'thumbnail': 'content2.png',
      'target_amount': '6,000원 남음',
      'like': false,
    }),
    Movie.fromMap({
      'title': '싱그러운 딸기 맛을 그대로',
      'body': 'test3',
      'thumbnail': 'content4.png',
      'target_amount': '6,000원 남음',
      'like': false,
    }),
  ];

  // List<Movie> movies = [];
  // bool isLoading = false;

  // _fetchMovie() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   final response =
  //       await http.get('http://lunarbear.pythonanywhere.com/post/post/');
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       movies = parseMovies(utf8.decode(response.bodyBytes));
  //       isLoading = false;
  //     });
  //   } else {
  //     throw Exception('failed to load data');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _buildListView(),
      ),
    );
  }

  Widget _buildListView() {
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            CarouselImage(movies: movies),
            TopBar(),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            '곧 마감입니다. 서둘러요!',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            '100%가 되면 종료됩니다.',
            style: TextStyle(fontSize: 10, color: Colors.black45),
          ),
        ),
        BoxSlider(
          movies: movies,
        )
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Tab(
            icon: Icon(
              Icons.search,
              size: 18,
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '기부니가좋다',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Tab(
            icon: Icon(
              Icons.notifications_none,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
