import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:netflix_clone_practice/model/firebase_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPage extends StatelessWidget {
  // GoogleSignInAccount _currentUser;
  FirebaseProvider fp;
  @override
  Widget build(BuildContext context) {
    fp = Provider.of<FirebaseProvider>(context);
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 50),
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                  'images/gibuni.png',
                ),
              ),
              // child: GoogleUserCircleAvatar(
              //   identity: _currentUser,
              // ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                fp.getUser().displayName ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              width: 140,
              height: 5,
              color: Colors.amber,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Linkify(
                onOpen: (link) async {
                  if (await canLaunch(link.url)) {
                    await launch(link.url);
                  }
                },
                text: 'https://github.com/gmuffiness',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              child: Text(fp.getUser().email),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: FlatButton(
                onPressed: () {},
                child: Container(
                  color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '프로필 수정하기',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.amber[800],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text('기부 참여'),
                    ),
                    Text('35건')
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.amber[800],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text('총 기부금'),
                    ),
                    Text('\$100')
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.amber[800],
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Text('기부니가 된지'),
                    ),
                    Text('53일')
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: RaisedButton(
                color: Colors.redAccent,
                child: Text(
                  "SIGN OUT",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  fp.signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
