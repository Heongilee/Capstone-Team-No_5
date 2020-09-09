import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/view/ChangeMyInfo.dart';
import 'package:recycle/view/HelpPage.dart';
import 'package:recycle/view/NoticePage.dart';
import 'package:recycle/view/ChangeMyInfo.dart';
import 'package:url_launcher/url_launcher.dart';

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 36.0;
}

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

  MyInfo(this._currentAccount);

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
              Padding(padding: EdgeInsets.all(4.0)),
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
                      document['email'] ?? '<No message retrived>',
                      textScaleFactor: 1.0,
                    );
                  }),
              Padding(
                padding: EdgeInsets.all(24.0),
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
                            builder: (context) =>
                                ChangeMyInfo(_currentAccount)));
                  },
                  label: Container(
                    width: 200.0,
                    child: Text(
                      '내 정보 변경',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
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
                    _emailSending("putitaway2020@gmail.com");
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
                  heroTag: 'help_key',
                  tooltip: "Hi, This is extended button.",
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  icon: Icon(Icons.help_outline),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          elevation: 0.0,
                          backgroundColor: Colors.transparent,
                          child: dialogContent(context),
                        );
                      },
                    );
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

  Future<void> _emailSending(String s) async {
    String _title = "";
    String _content = "";

    var url = "mailto:$s?subject=$_title&body=$_content";

    if (await canLaunch(url))
      await launch(url);
    else
      throw 'Could not launch $url';

    return;
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                "2020 공개SW 개발자대회",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '팀 이름',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '앱 버전: V1.0',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
              SizedBox(height: 10.0),
              Align(
                alignment: Alignment.center,
                child: FlatButton(
                  color: Colors.grey[200],
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text("닫 기"),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: Consts.avatarRadius,
            child: Image(image: AssetImage('assets/images/Logo.png')),
          ),
        ),
      ],
    );
  }
}
