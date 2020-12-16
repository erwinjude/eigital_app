import 'package:eigital_app/newsfeed_page.dart';
import 'package:eigital_app/weather_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarPage extends StatefulWidget {
  final userEmail;
  AppBarPage({this.userEmail});
  @override
  _AppBarPageState createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.userEmail,
                style: TextStyle(fontSize: 14),
              ),
              Container(
                child: FlatButton(
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: Text('Logout'),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
              ),
            ],
          ),
          bottom: TabBar(tabs: [
            Tab(text: 'NEWS FEED'),
            Tab(text: 'WEATHER'),
          ]),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            NewsFeedPage(),
            WeatherPage(),
          ],
        ),
      ),
    );
  }
}
