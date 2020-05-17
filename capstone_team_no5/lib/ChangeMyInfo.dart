import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      body: _buildBody(),
    );
  }
  ChangeMyInfo(this._currentAccount);

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text('내 정보 변경', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Center(
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
                          child: StreamBuilder<DocumentSnapshot>(
                            stream: _db.collection('user')
                            .document(_currentAccount.documentID)
                            .snapshots(),
                            builder: (context, snapshot) {
                              if(!snapshot.hasData){
                                return Center(child: CircularProgressIndicator());
                              }
                              else{
                                final DocumentSnapshot document = snapshot.data;
                                _id.text = document['id'];
                              return TextField(
                                controller: _id,
                                style: TextStyle(color: Colors.black),
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                ),
                                cursorColor: Colors.blue,
                              );
                              }
                            }
                          ),
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
                    color: Colors.white,
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
                          child: TextField(
                            controller: _name,
                            style: TextStyle(color: Colors.black),
                            readOnly: true,
                            decoration: InputDecoration(
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
                    onPressed: null,
                  ),
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
                          child: TextField(
                            controller: _phoneNum,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
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
              Padding(padding: EdgeInsets.all(10.0)),
              Flexible(
                // Email
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
                          "이메일",
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            controller: _email,
                            style: TextStyle(color: Colors.black),
                            readOnly: true,
                            decoration: InputDecoration(
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
              Padding(padding: EdgeInsets.all(50.0)),
              SizedBox(
                    width: 300,
                    child: RaisedButton(
                      child: Text(
                        '변 경',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: null
                    ),
              ),
          ],
        )
      ),
    );
  }
}
