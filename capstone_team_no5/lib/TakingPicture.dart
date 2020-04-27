import 'package:flutter/material.dart';

class TakingPicture extends StatefulWidget {
  @override
  _TakingPictureState createState() => _TakingPictureState();
}

class _TakingPictureState extends State<TakingPicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar();
  }

  Widget _buildBody() {
    return SafeArea(
      child: Center(
        child: Text('Hello !'),
      ),
    );
  }
}