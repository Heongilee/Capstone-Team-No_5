import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyInfo extends StatelessWidget {
  final DocumentSnapshot account_session;
  final _db = Firestore.instance;

  MyInfo(this.account_session);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
        centerTitle: true,                // 제목 가운데로 오게 하기.
        automaticallyImplyLeading: false, // 자동으로 뒤로가기 버튼 만드는거 false...
        backgroundColor: Colors.white,
        title: Text('내정보', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontStyle: FontStyle.italic),),
        actions: <Widget>[
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.exit_to_app), 
            // 로그아웃 버튼
            onPressed: (){
              _updateStatus(0);       // 로그인 -> 로그아웃으로 상태 전환 후,
              Navigator.pop(context); // 로그인 화면으로 이동!
            }
          ),
        ],
      );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(24.0),),
              SizedBox(
                height: 35.0,
                child: FloatingActionButton.extended(
                  tooltip: "Hi, This is extended button.",   //길게 누르면 설명 버튼이 뜸.
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  icon: Icon(Icons.assignment),
                  onPressed: (){

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

void _updateStatus(int v) async{
    // status 0이 들어오면 로그인 -> 로그아웃
    // status 1이 들어오면 로그아웃 -> 로그인
    if(v == 0){
      await _db.collection('user').document(account_session.documentID).updateData({'status' : 0});
      print('status를 정상적으로 0으로 변경했습니다.');
    }
    else{
      await _db.collection('user').document(account_session.documentID).updateData({'status' : 1});
      print('status를 정상적으로 1으로 변경했습니다.');
    }

    return;
  }
}