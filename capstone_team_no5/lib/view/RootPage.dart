import 'package:flutter/material.dart';
import 'package:recycle/controller/RootPageController.dart';
import 'package:recycle/model/MyApp_config.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // final _db = Firestore.instance;
  // DocumentSnapshot _currentDoc;
  // 로그인 환경 설정에서 불러온 계정이 이미 로그인중인지 체크할 변수

  @override
  void initState() {
    super.initState();
    MyApp_config();

    rootpageC.delaying(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage('assets/images/Logo.png')),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              '2020 공개SW 개발자대회',
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            Padding(padding: EdgeInsets.all(3.0)),
            Text(
              '생활 폐기물 품목 측정 기술',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Padding(padding: EdgeInsets.all(3.0)),
            Text(
              '팀 이 름',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
