import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class TakingPicture extends StatefulWidget {
  @override
  _TakingPictureState createState() => _TakingPictureState();
}

class _TakingPictureState extends State<TakingPicture> {
  File _image;
  List<Widget> _listViewItem = [];

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
              child: (_image == null) ? Center(child: Text('No Image')) : _buildListView(),
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

  Future _getImage() async{
    File image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      // 이미지 스트림이 들어오면 리스트가 repaint되는 식으로 작성!!
      _image = image;
      
      print(image.toString());
      // 중간에 이미지 촬영을 안 하고 바로 넘어갔을 경우... 처리
      if(_image != null)
        _addlistViewItem(_image);
    });
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _listViewItem.length,
      scrollDirection: Axis.horizontal,
      cacheExtent: 1500.0,
      itemBuilder: (BuildContext context, int idx) {
        return Container(
          child: Center(
            child: Container(
              padding: EdgeInsets.only(right: 10.0),
              width: 300.0,
              height: 300.0,
              child: _listViewItem[idx],
            ),
          ),
        );
      },
    );
  }

  void _addlistViewItem(File image) {
    _listViewItem.add(Image.file(image, fit: BoxFit.cover));
  }
}