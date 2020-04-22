//TODO : 0. dart:async를 import 해 준다.
import 'dart:async';

import 'package:flutter/material.dart';

class ButtonDesign extends StatefulWidget {
  @override
  _ButtonDesignState createState() => _ButtonDesignState();
}

class _ButtonDesignState extends State<ButtonDesign> {
  // TODO : 1. StreamController객체를 만든다. 
  StreamController _counterController = StreamController<String>() ..add("Not Applicable...");
  var _status = "Not Applicable...";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // TODO : 3. 보여질 부분을 StreamBuilder로 감싼다.
              StreamBuilder<String>(
                stream: _counterController.stream,
                builder: (context, snapshot) {
                  return Text('${snapshot.data}', 
                  style: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold));
                }
              ),

              Padding(padding: EdgeInsets.all(24.0),),
              SizedBox(
                height: 35.0,
                child: FloatingActionButton.extended(
                  tooltip: "Hi, This is extended button.",   //길게 누르면 설명 버튼이 뜸.
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  icon: Icon(Icons.assignment),
                  onPressed: (){
                    _status = "공지사항()";

                    // TODO : 2. StreamController.add([dynamic]) 를 호출해준다.
                    _counterController.add(_status);
                  }, 
                  label: Container(width: 200.0, child: Text('공 지 사 항', textAlign: TextAlign.center,)),
                ),
              ),
              Padding(padding: EdgeInsets.all(8.0),),
              SizedBox(
                height: 35.0,
                child: FloatingActionButton.extended(
                  tooltip: "Hi, This is extended button.",
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  icon: Icon(Icons.question_answer),
                  onPressed: (){
                    _status = "1:1문의()";

                    _counterController.add(_status);
                  }, 
                  label: Container(width: 200.0, child: Text('1 : 1  문 의', textAlign: TextAlign.center,)),
                ),
              ),
              Padding(padding: EdgeInsets.all(8.0),),
              SizedBox(
                height: 35.0,
                child: FloatingActionButton.extended(
                  tooltip: "Hi, This is extended button.",
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  icon: Icon(Icons.description),
                  onPressed: (){
                    _status = "이용안내()";

                    _counterController.add(_status);
                  }, 
                  label: Container(width: 200.0, child: Text('이 용 안 내', textAlign: TextAlign.center,)),
                ),
              ),
              Padding(padding: EdgeInsets.all(8.0),),
              SizedBox(
                height: 35.0,
                child: FloatingActionButton.extended(
                  tooltip: "Hi, This is extended button.",
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  icon: Icon(Icons.help_outline),
                  onPressed: (){
                    _status = "도움말()";
                    
                    _counterController.add(_status);
                  }, 
                  label: Container(width: 200.0, child: Text('도 움 말', textAlign: TextAlign.center,)),
                ),
              ),
            ],
          ),
        ),
        //bottomNavigationBar: BottomNavigationBar(items: null),
      ),
    );
  }
}