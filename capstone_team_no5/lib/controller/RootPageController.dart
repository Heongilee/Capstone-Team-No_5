import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recycle/model/MyApp_config.dart';
import 'package:recycle/model/AccountSnapshot.dart';
import 'package:recycle/view/MainPage.dart';
import 'package:recycle/view/RootPage.dart';
import 'package:recycle/view/TabPage.dart';
import 'package:recycle/controller/AccessMyFirestore.dart';

class RootPageController {
  bool _isAlreadyLogined;
  static final RootPageController _singleton =
      new RootPageController._internal();

  factory RootPageController() {
    return _singleton;
  }

  RootPageController._internal() {
    _isAlreadyLogined = false;
  }

  Future<void> delaying(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1500));

    // 디바이스에 있는 로그인 환경설정 정보를 불러옴.
    myapp_config_instance.readMyconfig().then((MyApp_config onValue) async {
      // TEST OUTPUT
      print("TEST OUTPUT 1 : " + onValue.toString()); // { admin, false, false }

      await checkMyAccount(onValue.receiveID);

      // 계정 정보가 있으면서, 자동 로그인 상태라면 바로
      if (myFirestore.currentDoc != null && onValue.chkboxAUTO == true) {
        Navigator.pushNamed(context, TabPage.routeName,
                arguments: TabPage_AccountSnapshot(myFirestore.currentDoc))
            .whenComplete(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        });
      } else {
        if (onValue.chkboxAUTO == false && _isAlreadyLogined == true)
          updateStatus(0); // 로그아웃 상태로 전환
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
  Future<void> checkMyAccount(String chkID) async {
    Future<dynamic> doc = myFirestore.db
        .collection('user')
        .where('id', isEqualTo: chkID)
        .getDocuments();
    await doc.then((qs) {
      myFirestore.currentDoc =
          (qs.documents.isEmpty) ? null : qs.documents.single;

      qs.documents.forEach((f) {
        if (f['status'] == 1) _isAlreadyLogined = true;
      });
    });

    return;
  }

  Future<void> updateStatus(int v) async {
    // status 0이 들어오면 로그인 -> 로그아웃
    // status 1이 들어오면 로그아웃 -> 로그인
    if (v == 0) {
      await myFirestore.db
          .collection('user')
          .document(myFirestore.currentDoc.documentID)
          .updateData({'status': 0});
      print('status를 정상적으로 0으로 변경했습니다.');
    } else {
      await myFirestore.db
          .collection('user')
          .document(myFirestore.currentDoc.documentID)
          .updateData({'status': 1});
      print('status를 정상적으로 1으로 변경했습니다.');
    }

    return;
  }
}

RootPageController rootpageC = new RootPageController();
