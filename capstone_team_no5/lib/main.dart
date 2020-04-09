import 'package:flutter/material.dart';
import 'package:recycle/RootPage.dart';

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
      home: RootPage(),
    );
  }
}
