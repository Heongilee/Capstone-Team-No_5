import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakingPicture extends StatefulWidget {
  @override
  _TakingPictureState createState() => _TakingPictureState();
}

class _TakingPictureState extends State<TakingPicture> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[600],
        child: Icon(Icons.add_a_photo),
        onPressed: _getImage,
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text("대형 폐기물 수거 신청", style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      leading: IconButton(icon: Icon(Icons.arrow_back_ios), color: Colors.black,onPressed: (){
        Navigator.pop(context);
      }),
      
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(24.0)),
            Container(
              width: 300.0,
              height: 300.0,
              // alignment: Alignment(0.0, 0.0),
              child: (_image == null) ? _takingPictureInfo() : Image.file(_image, fit: BoxFit.cover,), // 이미지 파일 영역
            ),
            Padding(padding: EdgeInsets.all(16.0)),
            SizedBox(
              width: 250.0,
              child: RaisedButton(
                child: Text('다 음', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
                onPressed: (){}
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _takingPictureInfo() {
    return Text('No Images', textAlign: TextAlign.center,);
  }

  Future _getImage() async{
    File image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
}