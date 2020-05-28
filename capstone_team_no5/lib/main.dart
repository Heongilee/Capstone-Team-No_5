import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recycle/MainPage.dart';
import 'package:recycle/RootPage.dart';
import 'package:recycle/TabPage.dart';
import 'package:recycle/TrashListComfirmation.dart';
import 'package:recycle/TakingPicture.dart';
import 'package:recycle/CustomerForm.dart';

import 'package:recycle/Example.dart';

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
      home: RootPage(),
      // home: ExamplePage(),
      routes: <String, WidgetBuilder>{
        '/MainPage': (BuildContext context) => new MainPage(),
        TakingPicture.routeName: (context) => TakingPicture(),
        TrashListComfirmation.routeName: (context) => TrashListComfirmation(),
        CustomerForm.routeName: (context) => CustomerForm(),
        TabPage.routeName: (context) => TabPage(),
      },
      onGenerateRoute: (settings) {
        // * 페이지 전환 효과를 주고 싶으면 이 영역에 추가시키면 됩니다.
        switch (settings.name) {
          case TabPage.routeName:
            return PageTransition(
                child: TabPage(), type: PageTransitionType.fade);
            break;
          default:
            return null;
            break;
        }
      },
    );
  }
}
