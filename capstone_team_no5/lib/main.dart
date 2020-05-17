import 'package:flutter/material.dart';
import 'package:recycle/NoticePage.dart';
import 'package:recycle/RootPage.dart'; // 원래 페이지
import 'package:recycle/SignUp.dart';
import 'package:recycle/MainPage.dart';
import 'package:recycle/TrashListComfirmation.dart';
import 'package:recycle/TakingPicture.dart';
import 'package:recycle/email_example.dart';

// 2020-05-07
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '치워',
      theme: ThemeData(
        brightness: Brightness.light,
        // brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      // home: EmailExample(),
      // home: TrashListComfirmation(),
      // home: TakingPicture(),
      // home: NoticePage(),
      home: RootPage(),
      routes: <String, WidgetBuilder>{
        '/TakingPicture': (BuildContext context) => new TakingPicture(),
      },
    );
  }
}
