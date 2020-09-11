// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone_practice/model/firebase_provider.dart';
import 'package:provider/provider.dart';

class CharityScreen extends StatefulWidget {
  @override
  _CharityScreenState createState() => _CharityScreenState();
}

enum Colname { SmallAction, OrangeDried, CharCoalPearl }

class _CharityScreenState extends State<CharityScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseProvider fp;

  // 컬렉션명
  String colname1 = "mP0buDOqPZ98rN70S9E8";
  String colname2 = "RKISuiAJFpQaqKAvxDAe";
  String colname3 = "f1PPN4IEpsOQdKpZT3zX";
  String colname = "";
  Colname colnameGroup = Colname.SmallAction;

  // 필드명
  final String fnUID = "UID";
  final String fnCoin = "coin";
  final String fnDatetime = "datetime";

  final String fnCoinSum = "coinSum";
  List coinList = List();
  // List _coinList = List();
  int sum = 0;
  String _fnMade = "";

  TextEditingController _newCoinCon = TextEditingController();
  TextEditingController _undCoinCon = TextEditingController();

  void initState() {
    super.initState();
    colname = colname1;
  }

  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("기부니들 명예의 전당($_fnMade)")),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300,
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('Posts/' + colname + '/User_log')
                  .orderBy(fnDatetime, descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text("Loading...");
                  default:
                    return ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        Timestamp ts = document[fnDatetime];
                        String dt = timestampToStrDateTime(ts);
                        coinList.add(int.parse(document[fnCoin]));
                        print(coinList);
                        return Card(
                          elevation: 2,
                          child: InkWell(
                            // Read Document
                            onTap: () {
                              showDocument(document.documentID);
                            },
                            // Update or Delete Document
                            onLongPress: () {
                              showUpdateOrDeleteDocDialog(document);
                            },

                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${document[fnCoin]}원 ',
                                        style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        dt.toString(),
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      fp.getUser().displayName,
                                      // document[fnUID],
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                    // ignore: dead_code
                    print("checkpoint");
                    // _coinList = coinList;
                    sum = coinList.reduce((a, b) => a + b);
                    coinList = List();
                  // updateCoinSum(document, sum);

                  // setState(() {
                  //   print("checkpoint");
                  //   // _coinList = coinList;
                  //   sum = coinList.reduce((a, b) => a + b);
                  //   coinList = List();
                  //   updateCoinSum(sum);
                  // });
                }
              },
            ),
          ),
          RadioListTile(
              title: Text('스몰액션'),
              value: Colname.SmallAction,
              groupValue: colname,
              onChanged: (value) {
                setState(() {
                  sum = 0;
                  colnameGroup = value;
                  colname = colname1;
                  coinList = List();
                  _fnMade = '스몰액션';
                });
              }),
          RadioListTile(
              title: Text('오렌지건어물'),
              value: Colname.OrangeDried,
              activeColor: Colors.blue,
              groupValue: colname,
              onChanged: (value) {
                setState(() {
                  sum = 0;
                  colnameGroup = value;
                  colname = colname2;
                  coinList = List();
                  _fnMade = '오렌지건어물';
                });
              }),
          RadioListTile(
              title: Text('숯진주연구소'),
              value: Colname.CharCoalPearl,
              activeColor: Colors.blue,
              groupValue: colname,
              onChanged: (value) {
                setState(() {
                  sum = 0;
                  colnameGroup = value;
                  colname = colname3;
                  coinList = List();
                  _fnMade = '숯진주연구소';
                });
              }),
          RaisedButton(
            onPressed: () {
              setState(() {
                // _coinList = coinList;
                sum = coinList.reduce((a, b) => a + b);
                coinList = List();
                updateCoinSum(sum);
              });
            },
            child: Text('${_fnMade}에 현재 모인 총금액 확인하기'),
          ),
          Text(
            '$sum 원',
            // '${_coinList[0] + _coinList[1]}, $sum', // to check if it's type == int or String
            textAlign: TextAlign.center,
          )
        ],
      ),
      // Create Document
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: showCreateDocDialog),
    );
  }

  /// Firestore CRUD Logic

  // 문서 생성 (Create)
  void createDoc(String coin) {
    Firestore.instance.collection('Posts/' + colname + '/User_log').add({
      fnUID: fp.getUser().uid,
      fnCoin: coin,
      fnDatetime: Timestamp.now(),
    });
  }

  // 문서 조회 (Read)
  void showDocument(String documentID) {
    Firestore.instance
        .collection('Posts/' + colname + '/User_log')
        .document(documentID)
        .get()
        .then((doc) {
      showReadDocSnackBar(doc);
    });
  }

  // 문서 갱신 (Update)
  void updateDoc(String docID, String coin) {
    Firestore.instance
        .collection('Posts/' + colname + '/User_log')
        .document(docID)
        .updateData({
      fnUID: fp.getUser().uid,
      fnCoin: coin,
    });
    print(docID);
  }

  // 문서 삭제 (Delete)
  void deleteDoc(String docID) {
    Firestore.instance
        .collection('Posts/' + colname + '/User_log')
        .document(docID)
        .delete();
  }

  void showCreateDocDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          // title: Text("Create New Document"),
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Coin"),
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
                  createDoc(_newCoinCon.text);
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

  void showReadDocSnackBar(DocumentSnapshot doc) {
    _scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.deepOrangeAccent,
          duration: Duration(seconds: 5),
          content: Text("$fnUID: ${doc[fnUID]}\n$fnCoin: ${doc[fnCoin]}"
              "\n$fnDatetime: ${timestampToStrDateTime(doc[fnDatetime])}"),
          action: SnackBarAction(
            label: "Done",
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
  }

  void showUpdateOrDeleteDocDialog(DocumentSnapshot doc) {
    _undCoinCon.text = doc[fnCoin];
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update/Delete Document"),
          content: Container(
            height: 200,
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Coin"),
                  controller: _undCoinCon,
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                _undCoinCon.clear();
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Update"),
              onPressed: () {
                if (_undCoinCon.text.isNotEmpty) {
                  updateDoc(doc.documentID, _undCoinCon.text);
                }
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Delete"),
              onPressed: () {
                deleteDoc(doc.documentID);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void updateCoinSum(int sum) {
    Firestore.instance.collection('Posts').document(colname).updateData({
      // fnUID: fp.getUser().uid,
      fnCoinSum: sum,
    });
  }

  String timestampToStrDateTime(Timestamp ts) {
    return DateTime.fromMicrosecondsSinceEpoch(ts.microsecondsSinceEpoch)
        .toString();
  }
}
