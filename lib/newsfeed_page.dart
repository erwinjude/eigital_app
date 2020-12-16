import 'package:eigital_app/news_source.dart';
import 'package:eigital_app/newswidget.dart';
import 'package:flutter/material.dart';

class NewsFeedPage extends StatefulWidget {
  @override
  _NewsFeedPageState createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  Source source = Source();
  List sourceList;

  @override
  void initState() {
    super.initState();
    getSource();
  }

  void getSource() async {
    List tempList = await source.getSourceList();
    setState(() {
      sourceList = tempList;
    });
  }

  NewsWidget getNewsWidget(int i) {
    return NewsWidget(
      imageUrl: sourceList[i]['urlToImage'],
      title: sourceList[i]['title'],
      description: sourceList[i]['description'],
      author: sourceList[i]['author'],
      url: sourceList[i]['url'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return sourceList == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: [
                      for (int i = 0; i < sourceList.length; i++)
                        getNewsWidget(i),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
