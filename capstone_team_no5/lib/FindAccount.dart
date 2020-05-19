import 'package:flutter/material.dart';

class FindAccount extends StatefulWidget {
  _FindAccountState createState() => _FindAccountState();
}

class _FindAccountState extends State<FindAccount> {
  ///Title
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
          '계정 찾기',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: find(context),
    );
  }

  Widget find(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(50.0)),
            Container(
              width: 330,
              child: Text(
                'Please enter the email you used to register for our app',
                style: TextStyle(fontSize: 25.0, color: Colors.black),
              ),
            ),
            Padding(padding: EdgeInsets.all(50.0)),
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
                        "Email",
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: TextField(
                          controller: TextEditingController(),
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
            Padding(padding: EdgeInsets.all(60.0)),
            Container(
              width: 280,
              child: Text('이메일로 해당 계정 정보가 전송 되었습니다.',
                  style: TextStyle(fontSize: 25.0, color: Colors.black),
                  textAlign: TextAlign.center),
            ),
            Padding(padding: EdgeInsets.all(80.0)),
            SizedBox(
              width: 300,
              child: RaisedButton(
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: null),
            ),
          ],
        ),
      ),
    );
  }
}
