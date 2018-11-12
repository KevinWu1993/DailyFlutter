import 'package:flutter/material.dart';
import 'daily/daily_page.dart';

void main() => runApp(MyApp());

//根布局
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '日报',
      theme: ThemeData(
        primarySwatch: Colors.blue, //主题
      ),
      home: DailyPage(title: '日报'), //主界面名称，这是一个可选命名参数
    );
  }
}



