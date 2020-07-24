import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kopo/kopo.dart';
import 'package:random_string/random_string.dart';
import 'package:recycle/model/EmailerModule.dart';
import 'package:recycle/model/MyHTTPhost.dart';

class signup_text_editing_controller {
  final _id = TextEditingController();
  final _pw = TextEditingController();
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _remaining_address = TextEditingController();
  final _phoneNum = TextEditingController();
  final _email = TextEditingController();
  final _comfilm = TextEditingController();
  String _authcode;

  // 0 : id,  1 : authentication code
  List<bool> valid_condition_List = [false, false];
}

class SignUp extends StatelessWidget with signup_text_editing_controller {
  StreamController _myCheckboxController = StreamController<bool>()..add(false);
  bool _myCheckbox = false;

  // DB Driver
  final _db = Firestore.instance;

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
    return SafeArea(
        child: Center(
      child: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          height: 800.0,
          child: Column(
            children: <Widget>[
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
                    onPressed: () {
                      _checkInternetAccess().then((bool onValue) {
                        if (onValue) {
                          checkmyId(context);
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
                    },
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
                            readOnly: true,
                            controller: _address,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: "직접 입력을 누르세요.",
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
                // etc address
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
                          "나머지 주소",
                          style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(right: 20),
                          child: TextField(
                            readOnly: false,
                            controller: _remaining_address,
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
                          '직접 입력',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      onPressed: () async {
                        _checkInternetAccess().then((bool onValue) {
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
                              hintText: "\t\t\'-\' 빼고 입력",
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
                      onPressed: () {
                        _checkInternetAccess().then((bool onValue) {
                          if (onValue) {
                            // node emailer(External Library) call
                            _emailSending(context);
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
                    onPressed: () async {
                      checkmyAuthCode().then((onValue) {
                        if (onValue) {
                          valid_condition_List[1] = true;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('SUCCESS'),
                                content: Text('인증이 완료되었습니다!'),
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
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('ERROR'),
                                content: Text('인증코드가 유효하지 않습니다.'),
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
                    },
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
                onPressed: () {
                  // checkValidInput().then((value) => insertionUserDB());
                  var my_switch_value = checkValidInput();
                  switch (my_switch_value) {
                    // 전부 유효한 입력의 경우... (이 경우에만 회원가입을 진행한다.)
                    case 0:
                      _checkInternetAccess().then((onValue) {
                        if (onValue) {
                          var doc = _db.collection('user').document();

                          doc.setData({
                            "id": _id.text,
                            "pw": _pw.text,
                            "name": _name.text,
                            "address":
                                _address.text + " " + _remaining_address.text,
                            "phoneNum": _phoneNum.text,
                            "email": _email.text,
                          }).then((value) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('SUCCESS'),
                                  content: Text('회원가입이 완료되었습니다.'),
                                  actions: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.popAndPushNamed(
                                              context, '/MainPage');
                                        },
                                        child: Text('Confirm')),
                                  ],
                                );
                              },
                            );
                          });
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
                      break;
                    // 인증코드만 불 일치하는 경우...
                    case 1:
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('ERROR'),
                            content: Text('인증코드를 다시 확인해주세요.'),
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
                      break;
                    // 아이디 검사가 이루어지지 않은 경우...
                    case 2:
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('ERROR'),
                            content: Text('아이디 중복을 체크 해주세요.'),
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
                      break;
                    // 전부 이루어지지 않은 경우...
                    case 3:
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('ERROR'),
                            content: Text('아이디와 인증코드를 \n다시 확인해주세요.'),
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
                      break;
                    default:
                      break;
                  }
                },
              ),
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

  // 유효한 입력인지 검사하는 메소드
  int checkValidInput() {
    if (valid_condition_List[0] && valid_condition_List[1]) {
      return 0;
    } else if (valid_condition_List[0] && !valid_condition_List[1]) {
      return 1;
    } else if (!valid_condition_List[0] && valid_condition_List[1]) {
      return 2;
    } else if (!valid_condition_List[0] && !valid_condition_List[1]) {
      return 3;
    }
  }

  // User DTO를 Firestore 'user'컬렉션에 삽입하는 메소드.
  Future<void> insertionUserDB() async {
    return;
  }

  // 중복확인 시, 중복되는 아이디가 있는지 체크함.
  Future<void> checkmyId(BuildContext context) async {
    if (_id.text.length == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text('아이디를 입력하세요.'),
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
      final QuerySnapshot result = await _db
          .collection('user')
          .where('id', isEqualTo: _id.text)
          .limit(1)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 1) {
        // 중복되는 아이디가 존재함.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('중복 오류'),
              content: Text('이미 존재하는 아이디 입니다.'),
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
        valid_condition_List[0] = true;
        // 중복되는 아이디가 존재하지 않음.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: null,
              content: Text('사용 가능한 아이디 입니다.'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      // 아이디 유효함 ON.
                      valid_condition_List[0] = true;

                      Navigator.of(context).pop();
                    },
                    child: Text('Confirm')),
              ],
            );
          },
        );
      }
    }

    return;
  }

  // 인증코드가 맞는지 체크하는 메소드.
  Future<bool> checkmyAuthCode() async {
    return (_comfilm.text == eObj.authenticationCode) ? true : false;
  }

  Future<bool> _checkInternetAccess() async {
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

  Future<bool> _emailSending(BuildContext context) async {
    _authcode = randomAlpha(6);

    // 싱글톤 객체 셋팅
    eObj.authenticationCode = _authcode;
    eObj.receipent = _email.text;
    eObj.ok = false;

    print('코드값은 ? ' + eObj.authenticationCode);

    var nodeEndPoint = httpHost.API_PREFIX;

    await _checkInternetAccess().then((bool onValue) {
      if (onValue) {
        http.post(nodeEndPoint, body: {
          "code": eObj.authenticationCode,
          "email": eObj.receipent
        }).then((res) {
          print(res.statusCode);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('SUCCESS'),
                content: Text('이메일을 정상적으로 전송했습니다.'),
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
        }).catchError((err) {
          print(err);
        });
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

    return eObj.ok;
  }
}
