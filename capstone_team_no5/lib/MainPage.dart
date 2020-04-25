import 'package:flutter/material.dart';
import 'package:recycle/TabPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatelessWidget {
  TextEditingController _id = TextEditingController();
  TextEditingController _pw = TextEditingController();
  final _db = Firestore.instance;
  DocumentSnapshot _currentDoc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible( // ID
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
          Flexible(   // Password
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
                        obscureText: true,  //비밀번호 텍스트 필드
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
          Padding(padding: EdgeInsets.all(8.0)),
          RaisedButton(
            child: Text('Submit'),
            color: Colors.grey[300],
            onPressed: (){
              var doc;
              doc = _db.collection('user').where("id", isEqualTo: _id.text).getDocuments().then((QuerySnapshot qs){
                _currentDoc = (qs.documents.isEmpty)? null : qs.documents.single;

                // TODO : _id랑 _pw가 빈 입력이 들어올 때 에러메시지 출력하도록 하기. (2020-04-22)
                if(_currentDoc != null){
                  // print("나의 현재 문서는 : "+ _currentDoc?.documentID);
                  qs.documents.forEach((f){
                    if(f['status'] == 1){
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('ERROR'),
                            content: Text('이미 로그인 중임다...'),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                }, 
                                child: Text('Confirm')),
                            ],
                          );
                        },
                      );
                    }
                    else{
                      if(f['pw'] == _pw.text){  // 패스워드 맞음
                        _updateStatus(1); // 로그인 상태로 전환.
                        _id.clear();
                        _pw.clear();

                        Navigator.push(context, MaterialPageRoute(builder: (context)=> TabPage(_currentDoc)));
                      }
                      else{                     // 패스워드 틀림
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text('ERROR'),
                              content: Text('비밀번호 틀림'),
                              actions: <Widget>[
                                FlatButton(
                                  onPressed: (){
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
                }
                else{
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text('ERROR'),
                        content: Text('아이디 없당'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            }, 
                            child: Text('Confirm')),
                        ],
                      );
                    },
                  );
                }
              });
            },
          ),
        ],
      ),
    );
  }

  void _updateStatus(int v) async{
    // status 0이 들어오면 로그인 -> 로그아웃
    // status 1이 들어오면 로그아웃 -> 로그인
    if(v == 0){
      await _db.collection('user').document(_currentDoc.documentID).updateData({'status' : 0});
      print('status를 정상적으로 0으로 변경했습니다.');
    }
    else{
      await _db.collection('user').document(_currentDoc.documentID).updateData({'status' : 1});
      print('status를 정상적으로 1으로 변경했습니다.');
    }
    
    return;
  }
} 