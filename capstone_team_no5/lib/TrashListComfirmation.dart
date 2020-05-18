import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/AccountSnapshot.dart';
import 'package:recycle/CustomerForm.dart';
import 'dart:io';

import 'MyAccountSnapshot.dart';
import 'TakingPicture.dart';

// TODO : TrashListComfirmation 생성자 외부로 빼기.
class TrashListComfirmation extends StatefulWidget {
  static const routeName = '/TrashListComfirmation';

  List<String> _resultPicture = ['의자', '가방']; // 외부 모듈 수행 결과를 받아와서 출력할 것.
  List<String> _detailProduct = [
    '의자',
    '가방',
    '1인용',
    '장의자',
    '바퀴달린의자(대형)',
    '바퀴달린의자(소형)'
  ]; // 외부 모듈 수행 결과를 받아와서 출력할 것.

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
    super.initState();

    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in widget._detailProduct) {
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
    final TrashListComfirmation_AccounSnapshot args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              // Navigator.popAndPushNamed(context, TakingPicture.routeName,
              //     arguments: TakingPicture_AccountSnapshot(_currentAccount));cm
              Navigator.popUntil(
                  context, ModalRoute.withName(TakingPicture.routeName));
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

  Widget _buildBody(TrashListComfirmation_AccounSnapshot args) {
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
                child: Center(
                    child: Image.file(
                        File(args.listViewItem[args.current_Idx].path))),
              ),
              Padding(padding: EdgeInsets.all(2.0)),
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
                      child: Text('다시찍기',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      onPressed: () {}),
                  Padding(padding: EdgeInsets.only(left: 40.0, right: 30.0)),
                  RaisedButton(
                      child: (args.current_Idx + 1 == args.listViewItem.length)
                          ? Text(' 신청하기 ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0))
                          : Text(' 다 음 ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0)),
                      onPressed: () {
                        if (args.current_Idx + 1 == args.listViewItem.length) {
                          Navigator.pushNamed(context, CustomerForm.routeName,
                              arguments: CustomerForm_AccountSnapshot(
                                  args.currentAccount));
                        } else {
                          Navigator.pushNamed(
                              context, TrashListComfirmation.routeName,
                              arguments: TrashListComfirmation_AccounSnapshot(
                                  args.currentAccount,
                                  args.listViewItem,
                                  args.current_Idx + 1));
                        }
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
