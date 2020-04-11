import 'package:flutter/material.dart';

class MyInfo extends StatelessWidget {
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
            onPressed: (){
              Navigator.pop(context);
            }
          ),
        ],
      );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Center(
      ),
    );
  }

}