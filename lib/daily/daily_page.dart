import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:zhihudaily/daily/daily_detail_page.dart';
import 'package:zhihudaily/repository/daily_repository_impl.dart';
import 'package:zhihudaily/model/daily_model.dart';
import 'package:transparent_image/transparent_image.dart';

//这是主界面，一个StatefulWidget
class DailyPage extends StatefulWidget {
  DailyPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PageState createState() => new _PageState();
}

class _PageState extends State<DailyPage> {
  DailyRepositoryImpl _dailyRepositoryImpl;
  List<News> _newsList = new List<News>();
  int _times = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dailyRepositoryImpl = new DailyRepositoryImpl();
    _refreshData(1);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: new Color(0xFFEAEAEA),
        appBar: AppBar(
          title: Text(widget.title +"   重复："+ _times.toString()), //主界面顶栏
        ),
        body: new RefreshIndicator(
            onRefresh: (){
              return _refreshData(1);
            },
            child: new ListView.builder(
              itemCount: _newsList.length,
              itemBuilder: _buildListItem,
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _refreshData(++_times);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );


  }

  Widget _buildListItem(BuildContext buildContext, int index) {
    News newsModel = _newsList[index];
    return new Container(
        height: 100.0,
        child: new GestureDetector(
          onTap: () async {
            if (Platform.isIOS) {
              if (await canLaunch(newsModel.shareUrl)) {
                await launch(newsModel.shareUrl);
              }
            } else {
              Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new DailyDetailPage(
                    title: newsModel.title,
                    url: newsModel.shareUrl,
                  )));
            }
          },
          child: new Card(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  margin: new EdgeInsets.all(5.0),
                  child: new FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: newsModel.image,
                    fit: BoxFit.cover,
                    height: 90.0,
                    width: 90.0,
                  ),
                ),
                new Expanded(
                  child: new Padding(
                    padding: new EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
                    child: new Text(
                      newsModel.title,
                      style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                      maxLines: 3,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future _refreshData(int times){
    _newsList.clear();
    return _dailyRepositoryImpl.loadData().then((dailyModel) {
      setState(() {
        List<News> tempList = new List<News>();
        for(int i = times;i>0; i--){
          tempList.addAll(dailyModel.news);
        }
        _newsList = tempList;
      });
    }).catchError((error) {
      print(error);
      return null;
    });
  }
}
