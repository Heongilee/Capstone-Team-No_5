import 'package:flutter/material.dart';
import 'dart:io';

class TrashListComfirmation extends StatefulWidget {
  List<File> _listViewItem; // 이미지 파일 리스트
  List<String> _resultPicture = ['null', 'null']; // 외부 모듈 수행 결과를 받아와서 출력할 것.
  // final current_Idx; // 현재 출력중인 페이지 번호 0 ~ [사진 갯수-1] 만큼

  // TrashListComfirmation(this._listViewItem, this.current_Idx);

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
  List<DropdownMenuItem<String>> _dropDownMenuItems2;

  String _currentCity;
  String _currentCity2;

  //제품 목록
  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    _dropDownMenuItems2 = getDropDownMenuItems();
    _currentCity2 = _dropDownMenuItems2[0].value;
    super.initState();
  }

  //제품 목록
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  //상세목록
  List<DropdownMenuItem<String>> getDropDownMenuItems2() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(value: city, child: new Text(city)));
    }
    return items;
  }

  //제목 목록
  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }

  //상세목록 변화
  void changedDropDownItem1(String selectedCity) {
    setState(() {
      _currentCity2 = selectedCity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.popAndPushNamed(context, '/TakingPicture');
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
      
      body: TrashList(),
    );
  }

  Widget TrashList() {
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
              Text('이사진',
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
                  value: _currentCity2,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem1,
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
