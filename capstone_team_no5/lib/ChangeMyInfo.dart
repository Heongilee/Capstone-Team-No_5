import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kopo/kopo.dart';

class ChangeMyInfo extends StatelessWidget {
  final DocumentSnapshot _currentAccount;
  final _db = Firestore.instance;
  final _id = TextEditingController();
  final _pw = TextEditingController();
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _phoneNum = TextEditingController();
  final _email = TextEditingController();
  final _comfilm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  ChangeMyInfo(this._currentAccount);

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text(
        '내 정보 변경',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
          child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(20.0)),
              Flexible(
                // ID
                child: Container(
                  alignment: Alignment(0.0, 0.0),
                  height: 45,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
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
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: _db
                                  .collection('user')
                                  .document(_currentAccount.documentID)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  final DocumentSnapshot document =
                                      snapshot.data;
                                  _id.text = document['id'];
                                  return TextField(
                                    controller: _id,
                                    style: TextStyle(color: Colors.black),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[300]),
                                    ),
                                    cursorColor: Colors.blue,
                                  );
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
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
                              hintStyle: TextStyle(color: Colors.grey[300]),
                              hintText: "변경할 패스워드를 입력하세요.",
                            ),
                            cursorColor: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              Flexible(
                // name
                child: Container(
                  alignment: Alignment(0.0, 0.0),
                  height: 45,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        child: Text(
                          "이름",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: _db
                                  .collection('user')
                                  .document(_currentAccount.documentID)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  final DocumentSnapshot document =
                                      snapshot.data;
                                  _name.text = document['name'];
                                  return TextField(
                                    controller: _name,
                                    style: TextStyle(color: Colors.black),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[300]),
                                    ),
                                    cursorColor: Colors.blue,
                                  );
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              Flexible(
                // address
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
                          "주소",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            readOnly: true,
                            controller: _address,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: null,
                              border: InputBorder.none,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                      child: Container(
                        // width: 100,
                        // height: 30,
                        // alignment: Alignment(0.0, 0.0),
                        child: Text(
                          '직접 입력',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      onPressed: () async {
                        _checkInternetAccess(context).then((bool onValue) {
                          if (onValue) {
                            _loadMyAddress(context);
                          } else {
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
                      }),
                  Padding(padding: EdgeInsets.only(left: 35.0)),
                ],
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Flexible(
                // phone
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
                          "전화번호",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: _db
                                  .collection('user')
                                  .document(_currentAccount.documentID)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  final DocumentSnapshot document =
                                      snapshot.data;
                                  _phoneNum.text = document['phoneNumber'];
                                  return TextField(
                                    controller: _phoneNum,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[300]),
                                    ),
                                    cursorColor: Colors.blue,
                                  );
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              Flexible(
                // Email
                child: Container(
                  alignment: Alignment(0.0, 0.0),
                  height: 45,
                  margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        child: Text(
                          "이메일",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: StreamBuilder<DocumentSnapshot>(
                              stream: _db
                                  .collection('user')
                                  .document(_currentAccount.documentID)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  final DocumentSnapshot document =
                                      snapshot.data;
                                  _email.text = document['email'];
                                  return TextField(
                                    controller: _email,
                                    style: TextStyle(color: Colors.black),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle:
                                          TextStyle(color: Colors.grey[300]),
                                    ),
                                    cursorColor: Colors.blue,
                                  );
                                }
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(50.0)),
              SizedBox(
                width: 300,
                child: RaisedButton(
                    child: Text(
                      '변 경',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed: null),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future<void> checkmyAuthCode() async {
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

  Future<void> _loadMyAddress(BuildContext context) async {
    KopoModel model = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Kopo(),
        ));
    print(model?.toJson());
    if (model?.toJson()?.isNotEmpty) {
      _address.text =
          '${model.address} ${model.buildingName}${model.apartment == 'Y' ? '아파트' : ''} ${model.zonecode} ';
      print('My Address is' + _address.text);
    }

    return;
  }
}
