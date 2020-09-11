import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone_practice/model/firebase_provider.dart';
import 'package:netflix_clone_practice/model/movie_model.dart';
import 'dart:ui';

import 'package:netflix_clone_practice/screen/charity_screen.dart';
import 'package:netflix_clone_practice/screen/home_screen.dart';
import 'package:netflix_clone_practice/widget/progress_bar_by_value.dart';
import 'package:provider/provider.dart';

class DetailScreen2 extends StatefulWidget {
  final Map movie;

  DetailScreen2({this.movie});

  @override
  _DetailScreen2State createState() => _DetailScreen2State();
}

class _DetailScreen2State extends State<DetailScreen2> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  // 컬렉션명

  // 필드명
  final String fnUID = "UID";
  final String fnCoin = "coin";
  final String fnDatetime = "datetime";

  List coinList = List();

  int sum = 0;

  TextEditingController _newCoinCon = TextEditingController();

  bool like = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    String colName = widget.movie[fndocID].toString();

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/gibuni.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.1),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                                  child: Image.network(
                                      widget.movie[fnThumb].toString()),
                                ),
                                Container(
                                  padding: EdgeInsets.all(7),
                                  child: Text(
                                    '83% 진행 중',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 23, color: Colors.white),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(7),
                                  child: Text(
                                    widget.movie[fnName].toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  child: RaisedButton(
                                    onPressed: () {
                                      showCreateDocDialog(colName);
                                    },
                                    color: Colors.amber,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '추첨 참여하러 가기',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                CustomProgressBar(
                                  width: 200,
                                  value: int.parse(
                                      widget.movie[fnCoinSum].toString()),
                                  totalValue: int.parse(
                                      widget.movie[fnGoal].toString()),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(sum.toString())
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  )
                ],
              ),
              Container(
                color: Colors.black26,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: <Widget>[
                            like
                                ? Icon(Icons.check)
                                : Icon(
                                    Icons.favorite,
                                    color: Colors.pink,
                                  ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Text(
                              '담아두기',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.thumb_up,
                              color: Colors.black,
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Text(
                              '좋아요',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.send),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              '공유',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createDoc(String coin, colname) {
    try {
      int.parse(coin).runtimeType == int;
    } on FormatException {
      _alertIntWarning();
    }
    if (int.parse(coin).runtimeType == int) {
      Firestore.instance.collection('Posts/' + colname + '/User_log').add({
        fnUID: fp.getUser().uid,
        fnCoin: coin,
        fnDatetime: Timestamp.now(),
      });
    } else {
      _alertIntWarning();
    }
  }

  void showCreateDocDialog(colname) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${widget.movie[fnMade].toString()}와 함께 기부하기"),
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                Text('기부하실 금액을 입력해주세요.'),
                TextField(
                  decoration: InputDecoration(labelText: "금액"),
                  controller: _newCoinCon,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                _newCoinCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Create"),
              onPressed: () {
                if (_newCoinCon.text.isNotEmpty) {
                  createDoc(_newCoinCon.text, colname);
                }

                _newCoinCon.clear();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void _alertIntWarning() {
    Navigator.pop(context);
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepOrangeAccent,
          duration: Duration(seconds: 5),
          content: Text("$fnCoin 은 숫자가 아닙니다. 기부하실 금액을 입력해주세요."),
          action: SnackBarAction(
            label: "Done",
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
  }
}
