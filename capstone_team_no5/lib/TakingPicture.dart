import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakingPicture extends StatefulWidget {
  @override
  _TakingPictureState createState() => _TakingPictureState();

}

class _TakingPictureState extends State<TakingPicture> {
  String serverResponse;
  File _image;
  // List<Widget> _listViewItem = [];
  List<File> _listViewItem = [];

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
      title: Text(
        "대형 폐기물 수거 신청",
        style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(24.0)),
            Container(
              width: 300.0,
              height: 300.0,
              child: (_listViewItem.length == 0)
                  ? Center(
                  child: Image(
                      image: AssetImage('assets/images/pictureGuide.png')))
                  : _buildListView(),
            ),
            Padding(padding: EdgeInsets.all(2.0)),
            Text(
              '● TIP : 이미지를 길게 누르면 사진을 목록에서 삭제 시킬 수 있어요!',
              textScaleFactor: 0.65,
            ),
            Padding(padding: EdgeInsets.all(14.0)),
            SizedBox(
              width: 250.0,
              child: RaisedButton(
                  child: Text(
                    '다 음',
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  onPressed: () {

                    // 사진 촬영이 하나도 안 됐을 경우, 에러 메시지 출력.
                    if (_listViewItem.length == 0) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('ERROR'),
                            content: Text('리스트에 사진이 하나도 없습니다. 사진을 촬영해주세요.'),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Confirm')),
                            ],
                          );
                        },
                      );
                    }
                    else{
                      _listViewItem.forEach((File element) {
                        final String nodeEndPoint = 'http://172.30.1.45:3000/image';

                        if (element == null) {
                          print("어 파일인식 안됨");
                          return;
                        }
                        String base64Image = base64Encode(element.readAsBytesSync());
                        String fileName = element.path.split("/").last;

                        print("파일이름 : " + fileName);
                        //print(base64Image);
                        http.post(nodeEndPoint, body: {
                          "image": base64Image,
                          "name": fileName,
                        }).then((res) {
                          print(res.body);
                          print("상태코드 : ");
                          print(res.statusCode);

                          String tmp=res.body;
                          //처리해주기

                        }).catchError((err) {
                          print(err);
                        });

                        print(33);
                        print(_makeGetRequest()); //Instance of 'Future<dynamic>' 출력이 됨


                      });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future _getImage() async {
    // 사진 앱 불러옴
    File image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      // 이미지 스트림이 들어오면 리스트가 repaint되는 식으로 작성!!
      _image = image;

      print(image.toString());
      // 중간에 이미지 촬영을 안 하고 바로 넘어갔을 경우... 처리
      if (_image != null) _addlistViewItem(_image);
      _image = null;
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
            child: GestureDetector(
              onLongPress: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                        title: Text('삭제하시겠습니까?'),
                        children: <Widget>[
                          SimpleDialogOption(
                              child: Text('예'),
                              onPressed: () {
                                setState(() {
                                  _listViewItem.remove(_listViewItem[idx]);
                                });
                                Navigator.of(context).pop();
                              }),
                          SimpleDialogOption(
                              child: Text('아니오'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ],
                      );
                    });
              },
              onTap: () {
                print('on Tap!');
              },
              child: Container(
                padding: EdgeInsets.only(right: 10.0),
                width: 300.0,
                height: 300.0,
                child: Image.file(
                  _listViewItem[idx],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );



  }


  void _addlistViewItem(File image) {
    _listViewItem.add(image);
  }
  _makeGetRequest() async {
    final response = await http.get(_localhost());

    if (response.statusCode == 200) {
      serverResponse = response.body;
      //print("서버 응답부분");print(serverResponse);
    return 1;
  }
  }

  String _localhost() {
    if (Platform.isAndroid)
      return 'http://172.30.1.45:3000/';
    else // for iOS simulator
      return 'http://172.30.1.45:3000/';
  }


}