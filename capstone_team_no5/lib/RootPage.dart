import 'dart:async';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recycle/MainPage.dart';
import 'MyApp_config.dart';
import 'TabPage.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>{
  
  @override
  void initState() { 
    super.initState();
    MyApp_config();

    _delaying(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: ,
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
            Text('생활 폐기물 품목 측정 기술', style: TextStyle(
              fontSize: 27.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),),
            Padding(padding: EdgeInsets.all(3.0)),
            Text('캡스톤 01반 5조', style: TextStyle(
              fontSize: 15.0,
            ),),
            Padding(padding: EdgeInsets.all(3.0)),
            Text('외 유 내 강', style: TextStyle(
              fontSize: 15.0,
            ),),
          ],
        ),
      ),
    );
  }

  Future<void> _delaying(BuildContext context) async{
    await Future.delayed(Duration(milliseconds: 2500));
    MyApp_config obj = new MyApp_config();

    obj.readMyconfig().then((MyApp_config onValue){
      print(onValue.toString());  // { , false, false }

      if(onValue.chkboxAUTO){ // 자동로그인이 설정되어 있는 경우...
        // TODO : receiveID값 Firestore의 user컬렉션에 있는 ID와 연결 후 로그인시킨다.
        // Navigator.pushReplacement로 하면 뒤로 다시 돌아올 수 없다.
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: TabPage(null),
            duration: Duration(milliseconds: 900),
          ),
        );
      }
      else{
        // Navigator.pushReplacement로 하면 뒤로 다시 돌아올 수 없다.
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: MainPage(), 
            duration: Duration(milliseconds: 900),
          ),
        );
      }
    });

    return;
  }
} 