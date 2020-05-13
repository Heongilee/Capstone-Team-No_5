import 'package:flutter/material.dart';

class ComplainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text('1:1  문의', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
        child: Text('1:1문의'),
      ),
    );
  }
}
