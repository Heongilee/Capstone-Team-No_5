import 'package:recycle/controller/FluttertoastPlugin.dart';
import 'package:recycle/controller/MainPageController.dart';
import 'package:recycle/view/SignUp.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with Mainpage_text_editing_controller {
  @override
  void initState() {
    super.initState();
    mainpageTC.checkboxController_remember_my_id.add(false);
    mainpageTC.checkboxController_auto_login.add(false);

    mainpageC.firebaseCloudMessaging_Listeners();

    mainpageC.setting_myAppConfig();
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
                          controller: mainpageTC.id,
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
                          controller: mainpageTC.pw,
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
                    stream: mainpageTC.checkboxController_remember_my_id.stream,
                    builder: (context, snapshot) {
                      return SizedBox(
                          height: 30.0,
                          child: Checkbox(
                              value: (snapshot.hasData) ? snapshot.data : false,
                              onChanged: (bool value1) {
                                // TODO : 아이디 기억
                                mainpageC.switch_checkbox('remember_my_id');
                              }));
                    }),
                Text('ID기억'),
                Padding(padding: EdgeInsets.only(left: 40.0, right: 30.0)),
                StreamBuilder<bool>(
                    stream: mainpageTC.checkboxController_auto_login.stream,
                    builder: (context, snapshot) {
                      return SizedBox(
                          height: 30.0,
                          child: Checkbox(
                              value: (snapshot.hasData) ? snapshot.data : false,
                              onChanged: (bool value2) {
                                // TODO : 자동 로그인
                                mainpageC.switch_checkbox('auto_login');
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
                  mainpageC.signInActionListener(context);
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
            Padding(padding: EdgeInsets.only(top: 24.0)),
            InkWell(
              child: Text('개발자 옵션 : 모든 계정 로그아웃.',
                  style: TextStyle(decoration: TextDecoration.underline)),
              onTap: () {
                mainpageC.allOfUserAccountSetSignOut().then((value) {
                  myFlutterToast.showMyToastAlertMsg("모든 유저를 로그아웃 시켰습니다.");
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
