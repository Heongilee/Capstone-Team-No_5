import 'dart:io';
import 'TakingPicture.dart';
import 'package:flutter/material.dart';
import 'package:recycle/CustomerForm.dart';
import 'package:recycle/WasteListAsset.dart';
import 'package:recycle/AccountSnapshot.dart';

class TrashListComfirmation extends StatefulWidget {
  List<String> my_result;
  static const routeName = '/TrashListComfirmation'; // 외부 모듈 수행 결과를 받아와서 출력할 것.

  // TODO : 새로고침 오류 고치기
  @override
  _TrashListComfirmationState createState() => _TrashListComfirmationState();
}

class _TrashListComfirmationState extends State<TrashListComfirmation> {
  WasteListAsset obj;

  File _image;

  List _resultPicture = ["null"];
  List _detailProduct = ["null"];

  List<DropdownMenuItem<String>> _dropDownMenuItems_Product;
  List<DropdownMenuItem<String>> _dropDownMenuItems_Detail;

  String _currentProduct;
  String _currentDetail;

  @override
  void initState() {
    obj = new WasteListAsset();

    // TODO : 외부 딥러닝 모델 호출(_myDeepLearningModule).
    _myDeepLearningModule().whenComplete(() {
      _dropDownMenuItems_Product =
          getDropDownMenuItems_Product(widget.my_result);
      _currentProduct = _dropDownMenuItems_Product[0].value;
    });

    super.initState();
  }

  //제품 목록
  List<DropdownMenuItem<String>> getDropDownMenuItems_Product(
      List<String> myDeepLearningResults) {
    List<DropdownMenuItem<String>> items = new List();

    for (String i in myDeepLearningResults) {
      // 딥러닝 결과가 매칭된 폐기물 품목 리스트만 items에 add 시킬 것.
      if (WasteListAsset().trashList.containsKey(i))
        items.add(DropdownMenuItem(value: i, child: Text(i)));
    }
    // WasteListAsset().trashList.forEach((key, value) {
    //   items.add(new DropdownMenuItem(value: key, child: new Text(key)));
    // });
    return items;
  }

  //상세목록
  List<DropdownMenuItem<String>> getDropDownMenuItems_Detail(
      String selectedItem) {
    List<DropdownMenuItem<String>> items = new List();

    for (String i in WasteListAsset().trashList[selectedItem].detailWaste) {
      items.add(new DropdownMenuItem(value: i, child: new Text(i)));
    }
    return items;
  }

  //제품 목록
  void changedDropDownItem(String selectedItem) {
    setState(() {
      _currentProduct = selectedItem;

      //상세 목록 동적 생성
      _dropDownMenuItems_Detail = getDropDownMenuItems_Detail(selectedItem);
      _currentDetail = _dropDownMenuItems_Detail[0].value;
    });
  }

  //상세목록 변화
  void changedDropDownItem1(String selectedItem) {
    setState(() {
      _currentDetail = selectedItem;
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
                      File(args.listViewItem[args.current_Idx].path)),
                ),
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
                  value: _currentProduct,
                  items: _dropDownMenuItems_Product,
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
                  value: _currentDetail,
                  items: _dropDownMenuItems_Detail,
                  onChanged: changedDropDownItem1,
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

  Future<void> _myDeepLearningModule() async {
    // * 반드시 ','가 아닌 ', '으로 구분되어야 합니다. 분류 체계 이름중에 콤마(,)를 사용하는 문자열이 있기 때문이죠.
    var module_result = "장롱, 비키니 옷장, 싱크대, 책상, 책장, 책꽂이";

    widget.my_result = module_result.split(', ');

    return;
  }
}
