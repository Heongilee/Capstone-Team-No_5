import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:async';

class signup_text_editing_controller {
  final _id = TextEditingController();
  final _pw = TextEditingController();
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _phoneNum = TextEditingController();
  final _email = TextEditingController();
  final _comfilm = TextEditingController();
  StreamController _checkboxController_agree = StreamController<bool>()
    ..add(false);
  bool agree = false;
}

class SignUp extends StatelessWidget with signup_text_editing_controller {
  StreamController _myCheckboxController = StreamController<bool>()..add(false);
  bool _myCheckbox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'SIGN UP',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: signup(context),
    );
  }

//body
  Widget signup(BuildContext context) {
    var white;
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(24.0)),
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
                          '중복 확인',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      onPressed: null,
                    ),
                    Padding(padding: EdgeInsets.only(left: 35.0)),
                  ],
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
                              controller: _address,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      child: Container(
                        // width: 100,
                        // height: 30,
                        // alignment: Alignment(0.0, 0.0),
                        child: Text(
                          '직접입력',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      onPressed: null,
                    ),
                    Padding(padding: EdgeInsets.only(left: 35.0)),
                  ],
                ),
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
                // TODO : 이메일 인증 버튼!!
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      child: Container(
                        // width: 100,
                        // height: 30,
                        // alignment: Alignment(0.0, 0.0),
                        child: Text(
                          '이메일 인증',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      onPressed: null,
                    ),
                    Padding(padding: EdgeInsets.only(left: 35.0)),
                  ],
                ),
                Flexible(
                  // 인증코드
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
                            "인증코드",
                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: TextField(
                              controller: _comfilm,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      child: Container(
                        // width: 100,
                        // height: 30,
                        // alignment: Alignment(0.0, 0.0),
                        child: Text(
                          '인증 확인',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      onPressed: null,
                    ),
                    Padding(padding: EdgeInsets.only(left: 35.0)),
                  ],
                ),
                Padding(padding: EdgeInsets.all(20.0)),
                RaisedButton(
                  child: Container(
                    width: 100,
                    // height: 30,
                    // alignment: Alignment(0.0, 0.0),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onPressed: null,
                ),
                // StreamBuilder<bool>(
                //       stream: _checkboxController_agree.stream,
                //       builder: (context, snapshot) {
                //         return SizedBox(
                //             height: 30.0,
                //             child: Checkbox(
                //                 value: snapshot.data,
                //                 onChanged: (bool value1) {
                //                   // TODO : 아이디 기억
                //                   switch_checkBox();
                //                 }));
                //       }),
                //   Text('약간동의'),
                //   Padding(padding: EdgeInsets.only(left: 40.0, right: 30.0)),
              ],
            ),
          ),
        ),
    ));
  }

  void switch_myCheckbox() {
    _myCheckbox = (_myCheckbox == true) ? false : true;

    _myCheckboxController.add(_myCheckbox);

    return;
  }

  //체크박스 관리
  // void switch_checkBox(){
  //   agree = agree ? false : true;
  //   _checkboxController_agree.add(agree);
  //   return;
  // }
}
//초기화 방법
// @override
// void initState() {
//   // TODO: implement initState
//   super.initState();

//   _a = 'Click me';
// }
