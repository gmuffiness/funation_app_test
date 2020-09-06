import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        height: 50,
        child: TabBar(
          labelColor: Colors.deepOrange,
          unselectedLabelColor: Colors.black,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.home,
                size: 18,
              ),
              child: Text(
                '홈',
                style: TextStyle(fontSize: 9),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.favorite_border,
                size: 18,
              ),
              child: Text(
                '기부참여',
                style: TextStyle(fontSize: 9),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.chat_bubble_outline,
                size: 18,
              ),
              child: Text(
                '추첨확인',
                style: TextStyle(fontSize: 9),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.border_all,
                size: 18,
              ),
              child: Text(
                '기부니들',
                style: TextStyle(fontSize: 9),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.account_circle,
                size: 18,
              ),
              child: Text(
                '마이페이지',
                style: TextStyle(fontSize: 9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
