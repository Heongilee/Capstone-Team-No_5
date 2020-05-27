import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recycle/AccountSnapshot.dart';
import 'package:recycle/MyApp_config.dart';

import 'package:flutter/material.dart';
import 'package:recycle/SignUp.dart';
import 'package:recycle/TabPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class mainpage_text_editing_controller {
  final _id = TextEditingController();
  final _pw = TextEditingController();
  StreamController _checkboxController_remember_my_id = StreamController<bool>()
    ..add(false);
  StreamController _checkboxController_auto_login = StreamController<bool>()
    ..add(false);
  bool remember_my_id = false;
  bool auto_login = false;

  void setRecent_my_id() {}
  void switch_checkbox(dynamic text) {}
  void dispose() {
    _checkboxController_remember_my_id.close();
    _checkboxController_auto_login.close();
  }
}

class MainPage extends StatelessWidget with mainpage_text_editing_controller {
  final _db = Firestore.instance;
  DocumentSnapshot _currentDoc;

  // 기본 생성자 오버로딩
  MainPage() {
    // 싱글톤 객체 호출
    MyApp_config().readMyconfig().then((obj) {
      _checkboxController_remember_my_id.add(obj.chkboxID);
      _checkboxController_auto_login.add(obj.chkboxAUTO);
      _id.text = obj.receiveID;
    });
  }

  @override
  void switch_checkbox(text) {
    super.switch_checkbox(text);

    if (text == "remember_my_id") {
      remember_my_id = (remember_my_id == false) ? true : false;
      _checkboxController_remember_my_id.add(remember_my_id);
    } else if (text == "auto_login") {
      auto_login = (auto_login == false) ? true : false;
      _checkboxController_auto_login.add(auto_login);
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      //appBar: AppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(right: 30.0)),
                Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 50.0)),
            Flexible(
              // ID
              child: Container(
                alignment: Alignment(0.0, 0.0),
                height: 45,
                margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1, color: Colors.black12),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      child: Text(
                        "ID",
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: TextField(
                          controller: _id,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Input Your ID",
                            hintStyle: TextStyle(color: Colors.grey[300]),
                          ),
                          cursorColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              // Password
              child: Container(
                alignment: Alignment(0.0, 0.0),
                height: 45,
                margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                padding: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(width: 1, color: Colors.black12),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      child: Text(
                        "PW",
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: TextField(
                          obscureText: true, //비밀번호 텍스트 필드
                          controller: _pw,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Input Your Password",
                            hintStyle: TextStyle(color: Colors.grey[300]),
                          ),
                          cursorColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(padding: EdgeInsets.all(8.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<bool>(
                    stream: _checkboxController_remember_my_id.stream,
                    builder: (context, snapshot) {
                      return SizedBox(
                          height: 30.0,
                          child: Checkbox(
                              value: snapshot.data,
                              onChanged: (bool value1) {
                                // TODO : 아이디 기억
                                switch_checkbox('remember_my_id');
                              }));
                    }),
                Text('ID기억'),
                Padding(padding: EdgeInsets.only(left: 40.0, right: 30.0)),
                StreamBuilder<bool>(
                    stream: _checkboxController_auto_login.stream,
                    builder: (context, snapshot) {
                      return SizedBox(
                          height: 30.0,
                          child: Checkbox(
                              value: snapshot.data,
                              onChanged: (bool value2) {
                                // TODO : 자동 로그인
                                switch_checkbox('auto_login');
                              }));
                    }),
                Text('자동 로그인'),
              ],
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            SizedBox(
              width: 300.0,
              child: RaisedButton(
                child: Text(
                  'SIGN IN',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.grey[300],
                onPressed: () {
                  _checkInternetAccess(context).then((bool onValue) {
                    if (onValue) {
                      // 인터넷 연결이 원활한 상태
                      var doc;
                      doc = _db
                          .collection('user')
                          .where("id", isEqualTo: _id.text)
                          .getDocuments()
                          .then((QuerySnapshot qs) {
                        _currentDoc =
                            (qs.documents.isEmpty) ? null : qs.documents.single;

                        if (_id.text.isEmpty || _pw.text.isEmpty) {
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
                        } else if (_currentDoc != null) {
                          // print("나의 현재 문서는 : "+ _currentDoc?.documentID);
                          qs.documents.forEach((f) {
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
                              if (f['pw'] == _pw.text) {
                                // 패스워드 맞음
                                _updateStatus(1); // 로그인 상태로 전환.

                                // dispose();  // Stream close
                                MyApp_config().chkboxID = remember_my_id;
                                MyApp_config().chkboxAUTO = auto_login;
                                MyApp_config().receiveID =
                                    (MyApp_config().chkboxID ||
                                            MyApp_config().chkboxAUTO)
                                        ? _id.text
                                        : "";
                                MyApp_config()
                                    .writeMyconfig(MyApp_config().toJson());

                                // 페이지 전환으로 인한 텍스트 필드값 초기화
                                if (!remember_my_id) {
                                  _id.clear();
                                }
                                _pw.clear();

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             TabPage(_currentDoc)));
                                Navigator.pushNamed(context, TabPage.routeName,
                                    arguments:
                                        TabPage_AccountSnapshot(_currentDoc));
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
                }, // onPressed()
              ),
            ),
            Container(
              alignment: Alignment(0.0, 0.0),
              height: 40.0,
              child: InkWell(
                child: Text(
                  'Forget your ID or password?',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                onTap: () {
                  print('Forget your ID or password?');
                },
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 70.0)),
            SizedBox(
              width: 300.0,
              child: RaisedButton(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  }),
            ),
            Padding(padding: EdgeInsets.only(top:24.0)),
            InkWell(
              child: Text('개발자 옵션 : 모든 계정 로그아웃.', style: TextStyle(decoration: TextDecoration.underline)),
              onTap: () {
                _allOfUserAccountSetSignOut().then((value) {
                  _showMyToastAlertMsg("모든 유저를 로그아웃 시켰습니다.");
                });
              },
            ),
          ],
        ),
      ),
    );
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

  Future<bool> _checkInternetAccess(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Connected');
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> _allOfUserAccountSetSignOut() async {
    QuerySnapshot qs = await _db.collection('user').getDocuments();
    // 모든 유저 문서에 대해 순회하면서...
    qs.documents.forEach((DocumentSnapshot user_doc) {
      // user_doc 유저의 status를 0(로그아웃 상태)으로 바꾼다.
      var doc = _db
          .collection('user')
          .document(user_doc.documentID)
          .updateData({'status': 0});
    });

    return;
  }

  void _showMyToastAlertMsg(String my_msg) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      webBgColor: "#e74c3c",
      timeInSecForIosWeb: 3,
      msg: my_msg);
  }
}
