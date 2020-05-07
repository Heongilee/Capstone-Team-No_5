import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/ComplainPage.dart';
import 'package:recycle/HelpPage.dart';
import 'package:recycle/NoticePage.dart';
import 'package:recycle/UserhelpPage.dart';

class UserInfo {
  static final UserInfo _instance = UserInfo._internal();
  String _currentMyID;

  factory UserInfo() {
    return _instance;
  }

  UserInfo._internal();
}

class MyInfo extends StatelessWidget {
  final DocumentSnapshot _currentAccount;
  final _db = Firestore.instance;
  var myUser;

  MyInfo(this._currentAccount) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true, // 제목 가운데로 오게 하기.
      automaticallyImplyLeading: false, // 자동으로 뒤로가기 버튼 만드는거 false...
      backgroundColor: Colors.white,
      title: Text(
        '내정보',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontStyle: FontStyle.italic),
      ),
      actions: <Widget>[
        IconButton(
            color: Colors.black,
            icon: Icon(Icons.exit_to_app),
            // 로그아웃 버튼
            onPressed: () {
              _updateStatus(0); // 로그인 -> 로그아웃으로 상태 전환 후,
              Navigator.pop(context); // 로그인 화면으로 이동!
            }),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<DocumentSnapshot>(
                  stream: _db
                      .collection('user')
                      .document(_currentAccount.documentID)
                      .snapshots(),
                  builder: (context, snapshot) {
                    // 스냅샷 데이터 검사는 함수 진입하고 맨 첫 줄에 해야함. 안 그러면 에러 남.
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    final DocumentSnapshot document = snapshot.data;
                    return Text(
                      document['id'] + ' 님 안녕하세요?' ?? '<No message retrived>',
                      textScaleFactor: 2.0,
                    );
                  }),
              Padding(
                padding: EdgeInsets.all(24.0),
              ),
              SizedBox(
                height: 35.0,
                child: FloatingActionButton.extended(
                  heroTag: 'noticePage_key',
                  tooltip: "Hi, This is extended button.", //길게 누르면 설명 버튼이 뜸.
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  icon: Icon(Icons.assignment),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NoticePage()));
                  },
                  label: Container(
                      width: 200.0,
                      child: Text(
                        '공 지 사 항',
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              SizedBox(
                height: 35.0,
                child: FloatingActionButton.extended(
                  heroTag: 'complain_key',
                  tooltip: "Hi, This is extended button.",
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  icon: Icon(Icons.question_answer),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ComplainPage()));
                  },
                  label: Container(
                      width: 200.0,
                      child: Text(
                        '1 : 1  문 의',
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              SizedBox(
                height: 35.0,
                child: FloatingActionButton.extended(
                  heroTag: 'Userhelp_key',
                  tooltip: "Hi, This is extended button.",
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  icon: Icon(Icons.description),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserhelpPage()));
                  },
                  label: Container(
                      width: 200.0,
                      child: Text(
                        '이 용 안 내',
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              SizedBox(
                height: 35.0,
                child: FloatingActionButton.extended(
                  heroTag: 'help_key',
                  tooltip: "Hi, This is extended button.",
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  icon: Icon(Icons.help_outline),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HelpPage()));
                  },
                  label: Container(
                      width: 200.0,
                      child: Text(
                        '도 움 말',
                        textAlign: TextAlign.center,
                      )),
                ),
              ),
              Padding(padding: EdgeInsets.only()),
              Text('test'),
            ],
          ),
        ),
        //bottomNavigationBar: BottomNavigationBar(items: null),
      ),
    );
  }

  void _updateStatus(int v) async {
    // status 0이 들어오면 로그인 -> 로그아웃
    // status 1이 들어오면 로그아웃 -> 로그인
    if (v == 0) {
      await _db
          .collection('user')
          .document(_currentAccount.documentID)
          .updateData({'status': 0});
      print('status를 정상적으로 0으로 변경했습니다.');
    } else {
      await _db
          .collection('user')
          .document(_currentAccount.documentID)
          .updateData({'status': 1});
      print('status를 정상적으로 1으로 변경했습니다.');
    }

    return;
  }
}
