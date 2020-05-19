import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recycle/AccountSnapshot.dart';
import 'package:recycle/MainPage.dart';
import 'MyApp_config.dart';
import 'TabPage.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final _db = Firestore.instance;
  DocumentSnapshot _currentDoc;
  bool _checkV1 = false;

  @override
  void initState() {
    super.initState();
    MyApp_config();

    _delaying(context);
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
              '생활 폐기물 품목 측정 기술',
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            Padding(padding: EdgeInsets.all(3.0)),
            Text(
              '캡스톤 01반 5조',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Padding(padding: EdgeInsets.all(3.0)),
            Text(
              '외 유 내 강',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _delaying(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1500));

    MyApp_config().readMyconfig().then((MyApp_config onValue) async {
      // TEST OUTPUT
      print("TEST OUTPUT 1 : " + onValue.toString()); // { admin, false, false }

      await accessMyFirestore(onValue.receiveID);

      if (_currentDoc != null && onValue.chkboxAUTO == true) {
        // Navigator.pushReplacement로 하면 뒤로 다시 돌아올 수 없다.
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     type: PageTransitionType.fade,
        //     child: TabPage(_currentDoc),
        //     duration: Duration(milliseconds: 900),
        //   ),
        // ).whenComplete(() {
        //   // There are multiple heroes that share the same tag within a subtree. 에러 뜨는데 걍 무시.
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
        // });
        Navigator.pushNamed(context, TabPage.routeName,
                arguments: TabPage_AccountSnapshot(_currentDoc))
            .whenComplete(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        });
      } else {
        if (onValue.chkboxAUTO == false && _checkV1 == true) {
          _updateStatus(0); // 로그아웃 상태로 전환
        }
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

  // * 계정 정보가 있으면 qs.documents.single을 반환, 계정 정보를 찾지 못하면 null반환.
  Future<void> accessMyFirestore(String chkID) async {
    Future<dynamic> doc =
        _db.collection('user').where('id', isEqualTo: chkID).getDocuments();
    await doc.then((qs) {
      _currentDoc = (qs.documents.isEmpty) ? null : qs.documents.single;

      qs.documents.forEach((f) {
        if (f['status'] == 1) _checkV1 = true;
      });
    });

    return;
  }

  Future<void> _updateStatus(int v) async {
    // status 0이 들어오면 로그인 -> 로그아웃
    // status 1이 들어오면 로그아웃 -> 로그인
    if (v == 0) {
      await _db
          .collection('user')
          .document(_currentDoc.documentID)
          .updateData({'status': 0});
      print('status를 정상적으로 0으로 변경했습니다.');
    } else {
      await _db
          .collection('user')
          .document(_currentDoc.documentID)
          .updateData({'status': 1});
      print('status를 정상적으로 1으로 변경했습니다.');
    }

    return;
  }
}
