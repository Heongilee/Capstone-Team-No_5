import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  TextEditingController _id = TextEditingController();
  TextEditingController _pw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
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
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}