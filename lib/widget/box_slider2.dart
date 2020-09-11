import 'package:flutter/material.dart';
import 'package:netflix_clone_practice/model/movie_model.dart';
import 'package:netflix_clone_practice/screen/detail_screen.dart';
import 'package:netflix_clone_practice/screen/detail_screen2.dart';
import 'dart:ui';

import 'package:netflix_clone_practice/screen/home_screen.dart';

class BoxSlider2 extends StatelessWidget {
  final List movies;
  final Map movie;
  // List<Widget> results = [];
  BoxSlider2({this.movies, this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: makeBoxImages(context, movies),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> makeBoxImages(BuildContext context, List movies) {
  List<Widget> results = [];
  print(movies.length);
  for (var i = 0; i < movies.length; i++) {
    results.add(
      InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return DetailScreen2(
                  movie: movies[i],
                );
              }));
        },
        child: Container(
          padding: EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start // 텍스트 왼쪽 가게하고 싶으면 이거하고 수정 좀 하면 될 듯!
              children: <Widget>[
                Expanded(
                  // child: Image.asset('images/' + movies[i].thumbnail),
                  child: Image.network(movies[i][fnThumb]),
                ),
                Text(
                  movies[i][fnName].toString(),
                ),
                Text(
                  movies[i][fnDescription].toString(),
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  movies[i][fnCoin].toString(),
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  return results;
}
