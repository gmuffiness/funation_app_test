import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone_practice/model/movie_model.dart';
import 'package:netflix_clone_practice/screen/detail_screen.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;
  CarouselImage({this.movies});
  @override
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  List<Movie> movies;
  List<Widget> images;
  List<String> keywords;
  List<bool> likes;
  int _currentPage = 0;
  String _currentKeyword;
  @override
  void initState() {
    super.initState();
    movies = widget.movies; // Q. 여기서 widget은 어디로부터 온 것일까?
    images = movies.map((m) => Image.asset(m.thumbnail)).toList();
    keywords = movies.map((m) => m.body).toList();
    likes = movies.map((m) => m.like).toList();
    _currentKeyword = keywords[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
          ),
          // CarouselSlider(
          //   items: images,
          //   options: CarouselOptions(
          //     height: 200,
          //     onPageChanged: (index, reason) {
          //       setState(() {
          //         _currentPage = index;
          //         _currentKeyword = keywords[_currentPage];
          //       });
          //     },
          //   ),
          // ),
          Container(
            child: Image.asset(
              'images/logo.png',
            ),
          ),
          // Container(
          //   child: Text(
          //     _currentKeyword,
          //     style: TextStyle(fontSize: 11),
          //   ),
          // ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: makeIndicator(likes, _currentPage),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> makeIndicator(List list, int _currentPage) {
  List<Widget> results = [];
  for (var i = 0; i < list.length; i++) {
    results.add(
      Container(
        width: 8,
        height: 8,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentPage == i
              ? Color.fromRGBO(0, 0, 0, 0.9)
              : Color.fromRGBO(0, 0, 0, 0.4),
        ),
      ),
    );
  }
  return results;
}
