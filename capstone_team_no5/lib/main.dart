import 'package:flutter/material.dart';
import 'package:recycle/HomePage.dart';
import 'package:recycle/RootPage.dart'; // 원래 페이지
import 'package:recycle/SignUp.dart';   // 회원가입 페이지
import 'package:recycle/TabPage.dart';  // 탭 페이지 (홈, 예약조회, 내 정보)
import 'package:recycle/temp_buttondesign.dart';  // 테스트 페이지 1

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        // brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      // home: TabPage(),
      home: RootPage(),
      // home: ButtonDesign(),
      // home: SignUp(),
    );
  }
}
