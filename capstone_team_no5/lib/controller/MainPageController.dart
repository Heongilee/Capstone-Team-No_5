import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:recycle/model/AccountSnapshot.dart';
import 'package:recycle/model/MyApp_config.dart';
import 'package:recycle/view/TabPage.dart';
import 'AccessMyFirestore.dart';
import 'InternetCheckController.dart';

class Mainpage_text_editing_controller {
  final _id = TextEditingController();
  final _pw = TextEditingController();
  StreamController _checkboxController_remember_my_id =
      StreamController<bool>();
  StreamController _checkboxController_auto_login = StreamController<bool>();
  bool remember_my_id = false;
  bool auto_login = false;

  //getter
  get id => _id;
  get pw => _pw;
  get checkboxController_remember_my_id => _checkboxController_remember_my_id;
  get checkboxController_auto_login => _checkboxController_auto_login;

  void setRecent_my_id() {}
  void dispose() {
    _checkboxController_remember_my_id.close();
    _checkboxController_auto_login.close();
  }
}

final mainpageTC = new Mainpage_text_editing_controller();

class MainPageController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  //getter
  // user mode
  get firebaseCloudMessaging_Listeners => _firebaseCloudMessaging_Listeners;
  get switch_checkbox => _switch_checkbox;
  get setting_myAppConfig => _setting_myAppConfig;
  get updateStatus => _updateStatus;
  get isAlreadyLogined => _isAlreadyLogined;
  get signInActionListener => _signInActionListener;
  // admin mode
  get allOfUserAccountSetSignOut => _allOfUserAccountSetSignOut;

  void _signInActionListener(BuildContext context) {
    myInternetCheck.checkInternetAccess(context).then((bool onValue) {
      if (onValue) {
        // 인터넷 연결이 원활한 상태
        var doc;
        doc = myFirestore.db
            .collection('user')
            .where("id", isEqualTo: mainpageTC.id.text)
            .getDocuments()
            .then((QuerySnapshot qs) {
          myFirestore.currentDoc =
              (qs.documents.isEmpty) ? null : qs.documents.single;

          if (mainpageTC.id.text.isEmpty || mainpageTC.pw.text.isEmpty) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('ERROR'),
                  content: Text('필드는 전부 입력되어야 합니다.'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Confirm')),
                  ],
                );
              },
            );
          } else if (myFirestore.currentDoc != null) {
            // print("나의 현재 문서는 : "+ _currentDoc?.documentID);
            qs.documents.forEach((f) {
              mainpageC.isAlreadyLogined(f, context);
            });
          } else {
            // if(_currentDoc != null){...}
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('ERROR'),
                  content: Text('존재하지 않는 아이디 입니다.'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Confirm')),
                  ],
                );
              },
            );
          }
        });
      } else {
        // 연결이 원활하지 못 한 경우.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('인터넷 연결 오류'),
              content: Text('인터넷 연결 상태를 확인 바랍니다.'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Confirm')),
              ],
            );
          },
        );
      }
    });
  }

  void _isAlreadyLogined(DocumentSnapshot f, BuildContext context) {
    if (f['status'] == 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text('이미 로그인중인 아이디 입니다.'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Confirm')),
            ],
          );
        },
      );
    } else {
      //if(f['status'] == 1){...}
      if (f['pw'] == mainpageTC.pw.text) {
        // 패스워드 맞음
        mainpageC.updateStatus(1); // 로그인 상태로 전환.

        // dispose();  // Stream close
        myapp_config_instance.chkboxID = mainpageTC.remember_my_id;
        myapp_config_instance.chkboxAUTO = mainpageTC.auto_login;
        // ID기억이나, 자동로그인이 켜져있는 경우 receiveID를 받음.
        myapp_config_instance.receiveID =
            (myapp_config_instance.chkboxID || myapp_config_instance.chkboxAUTO)
                ? mainpageTC.id.text
                : "";

        print(
            "${myapp_config_instance.chkboxID}, ${myapp_config_instance.chkboxAUTO}");
        print(
            "---------- receiveID : ${myapp_config_instance.receiveID} | _id.text : ${mainpageTC.id.text}로 해당 정보가 저장되었습니다!!! ----------");
        myapp_config_instance.writeMyconfig(myapp_config_instance.toJson());

        // 페이지 전환으로 인한 텍스트 필드값 초기화
        if (!myapp_config_instance.chkboxID) mainpageTC.id.clear();
        mainpageTC.pw.clear();

        Navigator.pushNamed(context, TabPage.routeName,
            arguments: TabPage_AccountSnapshot(myFirestore.currentDoc));
      } else {
        // 패스워드 틀림
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('ERROR'),
              content: Text('비밀번호가 틀렸습니다.'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Confirm')),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> _updateStatus(int v) async {
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

  Future<void> _allOfUserAccountSetSignOut() async {
    QuerySnapshot qs = await myFirestore.db.collection('user').getDocuments();
    // 모든 유저 문서에 대해 순회하면서...
    qs.documents.forEach((DocumentSnapshot user_doc) {
      // user_doc 유저의 status를 0(로그아웃 상태)으로 바꾼다.
      var doc = myFirestore.db
          .collection('user')
          .document(user_doc.documentID)
          .updateData({'status': 0});
    });

    return;
  }

  Future<void> _setting_myAppConfig() async {
    // 싱글톤 객체 호출
    await myapp_config_instance.readMyconfig().then((obj) {
      mainpageTC.checkboxController_remember_my_id.add(obj.chkboxID);
      mainpageTC.checkboxController_auto_login.add(obj.chkboxAUTO);
      mainpageTC.id.text = obj.receiveID;
    });

    return;
  }

  void _switch_checkbox(dynamic text) {
    if (text == "remember_my_id") {
      mainpageTC.remember_my_id =
          (mainpageTC.remember_my_id == false) ? true : false;
      mainpageTC.checkboxController_remember_my_id
          .add(mainpageTC.remember_my_id);
    } else if (text == "auto_login") {
      mainpageTC.auto_login = (mainpageTC.auto_login == false) ? true : false;
      mainpageTC.checkboxController_auto_login.add(mainpageTC.auto_login);
    }

    return;
  }

  void _firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.getToken().then((token) {
      print('token:' + token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }
}

final mainpageC = new MainPageController();
