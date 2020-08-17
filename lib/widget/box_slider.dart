import 'package:flutter/material.dart';
import 'package:netflix_clone_practice/model/movie_model.dart';
import 'package:netflix_clone_practice/screen/detail_screen.dart';
import 'dart:ui';

class BoxSlider extends StatelessWidget {
  final List<Movie> movies;
  final Movie movie;

  BoxSlider({this.movies, this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text('지금 뜨는 콘텐츠'),
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

List<Widget> makeBoxImages(BuildContext context, List<Movie> movies) {
  List<Widget> results = [];
  for (var i = 0; i < movies.length; i++) {
    results.add(
      InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              fullscreenDialog: true,
              builder: (BuildContext context) {
                return DetailScreen(
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
                  child: Image.asset('images/' + movies[i].thumbnail),
                ),
                Text(
                  movies[i].title,
                ),
                Text(
                  movies[i].body,
                  style: TextStyle(fontSize: 11),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  return results;
}
// 1.
// child: Container(
//           padding: EdgeInsets.only(right: 10),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Image.asset('images/' + movies[i].poster),
//           ),
//         ),

// 2.
// child: Container(
//           padding: EdgeInsets.only(right: 10),
//           child: Column(
//             children: <Widget>[
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Image.asset(
//                   'images/' + movies[i].poster,
//                 ),
//               ),
//             ],
//           ),
//         ),
