import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'MyAccountSnapshot.dart';
import 'TakingPicture.dart';

// TODO : TrashListComfirmation 생성자 외부로 빼기. 
class TrashListComfirmation extends StatefulWidget {
  static const routeName = '/TrashListComfirmation';

  // List<File> _listViewItem; // 이미지 파일 리스트
  // final current_Idx; // 현재 출력중인 페이지 번호 0 ~ [사진 갯수-1] 만큼
  List<String> _resultPicture = ['null', 'null']; // 외부 모듈 수행 결과를 받아와서 출력할 것.

  @override
  _TrashListComfirmationState createState() => _TrashListComfirmationState();
}

class _TrashListComfirmationState extends State<TrashListComfirmation> {
  File _image;

  List _cities = [
    "Cluj-Napoca",
    "Bucuresti",
    "Timisoara",
    "Brasov",
    "Constanta"
  ];

  List<DropdownMenuItem<String>> _dropDownMenuItems;

  String _currentCity;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final MyAccountSnapshot args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.popAndPushNamed(context, TakingPicture.routeName,
                  arguments: MyAccountSnapshot(args._currentAccount));
            }),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '대형 폐기물 수거 신청',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: _buildBody(args),
    );
  }

  Widget _buildBody(MyAccountSnapshot _currentAccount) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(12.0)),
              Container(
                width: 300.0,
                height: 300.0,
                // child: Center(
                //     child: Image.file(
                //         File(widget._listViewItem[widget.current_Idx].path))),
              ),
              Padding(padding: EdgeInsets.all(2.0)),
              Text(
                '이사진',
                // '이 사진은 ' + widget._resultPicture[widget.current_Idx] + ' 입니다.',
                textScaleFactor: 2.0,
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              Text(
                '제품 목록',
                textScaleFactor: 1.5,
              ),
              Container(
                // width: 250,
                // color: Colors.grey[200],
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border.all(width: 1, style: BorderStyle.solid),
                  color: Colors.grey[200],
                ),
                child: DropdownButton(
                  value: _currentCity,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              Text(
                '상세 목록',
                textScaleFactor: 1.5,
              ),
              Container(
                // width: 250,
                // color: Colors.grey[200],
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border.all(width: 1, style: BorderStyle.solid),
                  color: Colors.grey[200],
                ),
                child: DropdownButton(
                  value: _currentCity,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      child: Text(
                        '다시찍기',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      onPressed: () {}),
                  Padding(padding: EdgeInsets.only(left: 40.0, right: 30.0)),
                  RaisedButton(
                      child: Text(
                        ' 다 음 ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      onPressed: () {}),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
