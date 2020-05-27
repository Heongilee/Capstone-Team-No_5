import 'dart:io';
import 'TakingPicture.dart';
import 'package:flutter/material.dart';
import 'package:recycle/CustomerForm.dart';
import 'package:recycle/model/WasteListAsset.dart';
import 'package:recycle/AccountSnapshot.dart';

class TrashListComfirmation extends StatefulWidget {
  static const routeName = '/TrashListComfirmation'; // 외부 모듈 수행 결과를 받아와서 출력할 것.

  @override
  _TrashListComfirmationState createState() => _TrashListComfirmationState();
}

class _TrashListComfirmationState extends State<TrashListComfirmation> {
  // 이전 페이지 인자를 불러오고나서 초기화 하기위한 변수.
  bool subInitState_flag;

  // 강남구청 폐기물 분류 클래스
  WasteListAsset waste_obj;

  File _image;

  // * 딥러닝 분석 결과를 리스트형태로 가져올 것임.
  List<String> _currentResult = ["제품 목록을 선택하세요."]; // 제품 목록
  List<String> _detailProduct = ["상세 목록을 선택하세요."]; // 상세 목록

  // DropdownMenu에 들어갈 아이템들이 DropdownMenuItem<String>타입으로 담긴 리스트.
  List<DropdownMenuItem<String>> _dropDownMenuItems_Product;
  List<DropdownMenuItem<String>> _dropDownMenuItems_Detail;

  // 현재 DropdownMenuItem이 선택된 값.
  String _currentProduct;
  String _currentDetail;

  @override
  void initState() {
    subInitState_flag = false;
    waste_obj = new WasteListAsset();

    _dropDownMenuItems_Detail = new List();
    _dropDownMenuItems_Detail.add(new DropdownMenuItem(
        value: _detailProduct[0], child: Text(_detailProduct[0])));
    _currentDetail = _dropDownMenuItems_Detail[0].value;

    super.initState();
  }

  //제품 목록
  List<DropdownMenuItem<String>> getDropDownMenuItems_Product(
      List<String> myDeepLearningResults) {
    //DropdownMenu에 추가시킬 items 리스트 선언. (이를 반환 시킬 것임.)
    List<DropdownMenuItem<String>> items = new List();

    for (String i in myDeepLearningResults) {
      // 딥러닝 결과와 매칭된 폐기물 품목 리스트만 items에 add 시킬 것.
      if (WasteListAsset().trashList.containsKey(i))
        items.add(new DropdownMenuItem(value: i, child: Text(i)));
      // end user가 제품 목록을 선택하기 전에 띄울 콤보박스 아이템
      if (i == "제품 목록을 선택하세요.")
        items.add(new DropdownMenuItem(value: i, child: Text(i)));
    }

    return items;
  }

  //상세목록
  List<DropdownMenuItem<String>> getDropDownMenuItems_Detail(
      String selectedItem) {
    List<DropdownMenuItem<String>> items = new List();

    // selectedItem(제품 목록)의 상세 목록(detailWaste)을 for문으로 순회하면서...
    for (String i in WasteListAsset().trashList[selectedItem].detailWaste) {
      // DropdownMenuItem에 추가시킨다.
      items.add(new DropdownMenuItem(value: i, child: new Text(i)));
    }
    return items;
  }

  //제품 목록 변화
  void changedDropDownProductItem(String selectedItem) {
    // _dropDownMenuItems_Detail.clear();
    setState(() {
      //제품 목록이 선택 되면 ...
      _currentProduct = selectedItem;

      //상세 목록을 동적 생성 한다.
      _dropDownMenuItems_Detail = getDropDownMenuItems_Detail(selectedItem);
      _currentDetail = _dropDownMenuItems_Detail[0].value;
    });
  }

  //상세목록 변화
  void changedDropDownDetailItem(String selectedItem) {
    setState(() {
      _currentDetail = selectedItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TrashListComfirmation_AccounSnapshot args =
        ModalRoute.of(context).settings.arguments;

    // subInitState : route를 통해 arguments 들이 들어오고 나서 콤보박스 리스트를 활성화 시킬 것임.
    if (subInitState_flag == false) {
      subInitState_flag = true;

      // 현재 인덱스의 딥러닝 분석 결과를(List<String>) 가져오고,
      _currentResult.addAll(args.myDeepLearningResultStr[args.current_Idx]);
      // 제품 목록 콤보박스에 추가시킨다.
      _dropDownMenuItems_Product = getDropDownMenuItems_Product(_currentResult);
      // 현재 제품목록 인덱스를 0번으로 셋팅한다.
      _currentProduct = _dropDownMenuItems_Product[0].value;
    }

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
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
                      File(args.listViewItem[args.current_Idx].path)),
                ),
              ),
              Padding(padding: EdgeInsets.all(2.0)),
              Text(
                '제품 목록',
                textScaleFactor: 1.5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border.all(width: 1, style: BorderStyle.solid),
                  color: Colors.grey[200],
                ),
                child: DropdownButton(
                  value: _currentProduct,
                  items: _dropDownMenuItems_Product,
                  onChanged: changedDropDownProductItem,
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              Text(
                '상세 목록',
                textScaleFactor: 1.5,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border.all(width: 1, style: BorderStyle.solid),
                  color: Colors.grey[200],
                ),
                child: DropdownButton(
                  value: _currentDetail,
                  items: _dropDownMenuItems_Detail,
                  onChanged: changedDropDownDetailItem,
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
                          // TrashListConfirmation.dart -> CustomerForm.dart
                          args.selectedListItem
                              .add({_currentProduct: _currentDetail});

                          // 최종 가격 합산
                          int temp_idx = waste_obj
                              .trashList[_currentProduct].detailWaste
                              .indexOf(_currentDetail);
                          args.totalPrice += waste_obj
                              .trashList[_currentProduct].wastePrice
                              .elementAt(temp_idx);

                          Navigator.pushNamed(context, CustomerForm.routeName,
                              arguments: CustomerForm_AccountSnapshot(
                                  args.currentAccount,
                                  args.selectedListItem,
                                  args.totalPrice));
                        } else {
                          // TrashListConfirmation.dart(현재 인덱스) -> TrashListConfirmation.dart(다음 인덱스)
                          args.selectedListItem
                              .add({_currentProduct: _currentDetail});

                          // 최종 가격 합산
                          int temp_idx = waste_obj
                              .trashList[_currentProduct].detailWaste
                              .indexOf(_currentDetail);
                          args.totalPrice += waste_obj
                              .trashList[_currentProduct].wastePrice
                              .elementAt(temp_idx);

                          Navigator.pushNamed(
                              context, TrashListComfirmation.routeName,
                              arguments: TrashListComfirmation_AccounSnapshot(
                                  args.currentAccount,
                                  args.listViewItem,
                                  args.current_Idx + 1,
                                  args.myDeepLearningResultStr,
                                  args.selectedListItem,
                                  args.totalPrice));
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
