import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'TakingPicture.dart';
import 'package:flutter/material.dart';
import 'package:recycle/view/CustomerForm.dart';
import 'package:recycle/model/WasteListAsset.dart';
import 'package:recycle/model/AccountSnapshot.dart';

class TrashListComfirmation extends StatefulWidget {
  static const routeName = '/TrashListComfirmation'; // 외부 모듈 수행 결과를 받아와서 출력할 것.

  @override
  _TrashListComfirmationState createState() => _TrashListComfirmationState();
}

class _TrashListComfirmationState extends State<TrashListComfirmation> {
  // 사용자가 선택한 _myTrashListSet -> _selectedListItem
  //! FIXME : args.selectedListItem 으로 받아올 것!
  Set<Map<String, String>> _selectedListItem = {};

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
  bool toggleValue = false;

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
    //같은 객체 중복 방지 리스트
    List<String> incheck = new List();

    for (String i in myDeepLearningResults) {
      // TODO : 만약 "noDetected" 결과라면...?
      if (i == "noDetected") {
        items.add(new DropdownMenuItem(value: i, child: Text(i)));
        break;
      }
      // 딥러닝 결과와 매칭된 폐기물 품목 리스트만 items에 add 시킬 것.
      else if (WasteListAsset().trashList.containsKey(i) &&
          !incheck.contains(i)) {
        incheck.add(i);
        items.add(new DropdownMenuItem(
            value: i, child: Text(WasteListAsset().trashList[i].koreaname)));
      }
      // end user가 제품 목록을 선택하기 전에 띄울 콤보박스 아이템
      else if (i == "제품 목록을 선택하세요." && !incheck.contains(i)) {
        incheck.add(i);
        items.add(new DropdownMenuItem(value: i, child: Text(i)));
      }
    }

    return items;
  }

  //상세목록
  List<DropdownMenuItem<String>> getDropDownMenuItems_Detail(
      String selectedItem) {
    List<DropdownMenuItem<String>> items = [
      new DropdownMenuItem(
          value: "상세 목록을 선택하세요.", child: new Text("상세 목록을 선택하세요."))
    ];

    if (_currentProduct == "noDetected") {
      items.add(new DropdownMenuItem(
          value: "noDetected", child: new Text("noDetected")));
    } else {
      // selectedItem(제품 목록)의 상세 목록(detailWaste)을 for문으로 순회하면서...
      for (String i in WasteListAsset().trashList[selectedItem].detailWaste) {
        // DropdownMenuItem에 추가시킨다.
        items.add(new DropdownMenuItem(value: i, child: new Text(i)));
      }
    }
    return items;
  }

  //제품 목록 변화
  void changedDropDownProductItem(String selectedItem) {
    setState(() {
      //제품 목록이 선택 되면 ...
      _currentProduct = selectedItem;

      //상세 목록 콤보박스 아이템을 동적 생성 한다.
      _dropDownMenuItems_Detail = getDropDownMenuItems_Detail(selectedItem);
      _currentDetail = _dropDownMenuItems_Detail[0].value;
    });
  }

  //상세목록 변화
  void changedDropDownDetailItem(String selectedItem) {
    if (_currentProduct == "제품 목록을 선택하세요." || selectedItem == "상세 목록을 선택하세요.")
      return;

    setState(() {
      _currentDetail = selectedItem;

      _addMyTrashListItem();
      _currentProduct = _dropDownMenuItems_Product[0].value;
      _currentDetail = _dropDownMenuItems_Detail[0].value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TrashListComfirmation_AccounSnapshot args =
        ModalRoute.of(context).settings.arguments;

    // subInitState : route를 통해 arguments 들이 들어오고 나서 콤보박스 리스트를 활성화 시킬 것임.
    if (subInitState_flag == false) {
      subInitState_flag = true;

      _selectedListItem = args.selectedListItem;

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
          child: Container(
            height: MediaQuery.of(context).size.height + 400.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(2.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('전체 리스트 조회'),
                    Padding(padding: EdgeInsets.all(2.0)),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: 30.0,
                      width: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: toggleValue
                              ? Colors.greenAccent[100]
                              : Colors.redAccent[100].withOpacity(0.5)),
                      child: Stack(children: <Widget>[
                        AnimatedPositioned(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          top: 3.0,
                          left: toggleValue ? 25.0 : 0.0,
                          right: toggleValue ? 0.0 : 25.0,
                          child: InkWell(
                            onTap: () {
                              _toggleButton(args);
                            },
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 500),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return RotationTransition(
                                    child: child, turns: animation);
                              },
                              child: toggleValue
                                  ? Icon(Icons.check_circle,
                                      color: Colors.green,
                                      size: 25.0,
                                      key: UniqueKey())
                                  : Icon(Icons.remove_circle_outline,
                                      color: Colors.red,
                                      size: 25.0,
                                      key: UniqueKey()),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Padding(padding: EdgeInsets.only(right: 30.0)),
                  ],
                ),
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
                Padding(padding: EdgeInsets.all(5.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 30.0)),
                    Text('폐기물 신청 목록',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic)),
                  ],
                ),
                Padding(padding: EdgeInsets.all(5.0)),
                Container(
                  width: 300.0,
                  height: 150.0,
                  color: Colors.grey[100],
                  child: _buildListView(args),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('다시찍기',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0)),
                      onPressed: () {
                        _getImage(args);
                      },
                    ),
                    Padding(padding: EdgeInsets.only(left: 40.0, right: 30.0)),
                    RaisedButton(
                        child:
                            (args.current_Idx + 1 == args.listViewItem.length)
                                ? Text(' 신청하기 ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0))
                                : Text(' 다 음 ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0)),
                        onPressed: () {
                          // TODO : 제품목록이나 상세목록을 선택하지 않았을 경우 에러메시지 출력하기.
                          if (_selectedListItem.length == 0) {
                            // * 제품 목록을 다시 선택하세요.
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('ERROR'),
                                  content: Text('제품 목록이나 상세 목록을 선택하시기 바랍니다.'),
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
                          } else {
                            // * 다음 페이지로...
                            if (args.current_Idx + 1 ==
                                args.listViewItem.length) {
                              // TrashListConfirmation.dart -> CustomerForm.dart
                              args.selectedListItem.addAll(_selectedListItem);

                              args.selectedListItem.forEach((Map trashProduct) {
                                int temp_idx = waste_obj
                                    .trashList[trashProduct.keys.first]
                                    .detailWaste
                                    .indexOf(trashProduct.values.first);
                                args.totalPrice += waste_obj
                                    .trashList[trashProduct.keys.first]
                                    .wastePrice
                                    .elementAt(temp_idx);
                              });

                              Navigator.pushNamed(
                                  context, CustomerForm.routeName,
                                  arguments: CustomerForm_AccountSnapshot(
                                      args.currentAccount,
                                      args.listViewItem,
                                      args.selectedListItem,
                                      args.totalPrice));
                            } else {
                              // TrashListConfirmation.dart(현재 인덱스) -> TrashListConfirmation.dart(다음 인덱스)
                              args.selectedListItem.addAll(_selectedListItem);

                              // if (!waste_obj.trashList
                              //     .containsKey(_currentProduct)) {
                              //   args.totalPrice += 0;
                              // } else {
                              //   // // TODO : 최종 가격 합산 하기
                              //   // int temp_idx = waste_obj
                              //   //     .trashList[_currentProduct].detailWaste
                              //   //     .indexOf(_currentDetail);
                              //   // args.totalPrice += waste_obj
                              //   //     .trashList[_currentProduct].wastePrice
                              //   //     .elementAt(temp_idx);
                              //   // print('${args.totalPrice}');
                              // }

                              Navigator.pushNamed(
                                  context, TrashListComfirmation.routeName,
                                  arguments:
                                      TrashListComfirmation_AccounSnapshot(
                                          args.currentAccount,
                                          args.listViewItem,
                                          args.current_Idx + 1,
                                          args.myDeepLearningResultStr,
                                          args.selectedListItem,
                                          args.totalPrice));
                            }
                          }
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _getImage(TrashListComfirmation_AccounSnapshot args) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          File image;
          return SimpleDialog(
            title: Text(
              '이미지를 불러올 방식을 선택하세요.',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: SimpleDialogOption(
                    child: Text('카메라 어플 실행'),
                    onPressed: () async {
                      Navigator.of(context).pop();

                      // 사진 앱 불러옴
                      image = await ImagePicker.pickImage(
                          source: ImageSource.camera);

                      setState(() {
                        // 중간에 이미지 촬영을 안 하고 바로 넘어갔을 경우... 처리
                        if (image != null)
                          args.listViewItem[args.current_Idx] = image;
                        image = null;
                      });
                    }),
              ),
              Container(
                  padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: SimpleDialogOption(
                      child: Text('갤러리에서 사진 선택'),
                      onPressed: () async {
                        Navigator.of(context).pop();

                        // 사진 앱 불러옴
                        image = await ImagePicker.pickImage(
                            source: ImageSource.gallery);

                        setState(() {
                          // 중간에 이미지 촬영을 안 하고 바로 넘어갔을 경우... 처리
                          if (image != null)
                            args.listViewItem[args.current_Idx] = image;
                          image = null;
                        });
                      })),
            ],
          );
        });
  }

  // 제품 목록, 상세 목록 아이템 리스트에 넣기 위한 메소드
  void _addMyTrashListItem() {
    if (_currentProduct == "noDetected" || _currentDetail == "noDetected") {
      // nothing...
    } else {
      _selectedListItem.add({_currentProduct: _currentDetail});
    }

    return;
  }

  Widget _buildListView(TrashListComfirmation_AccounSnapshot args) {
    return ListView.builder(
      itemCount: _selectedListItem.length * 2,
      itemBuilder: (context, index) {
        if (index.isOdd) {
          return Divider();
        } else {
          var realIdx = index ~/ 2;

          return _buildListItem(args, realIdx);
        }
      },
    );
  }

  Widget _buildListItem(
      TrashListComfirmation_AccounSnapshot args, int realIdx) {
    Map listItemMap = _selectedListItem.toList()[realIdx];
    int temp_idx = waste_obj.trashList[listItemMap.keys.first].detailWaste
        .indexOf(listItemMap.values.first);
    int temp_price = waste_obj.trashList[listItemMap.keys.first].wastePrice
        .elementAt(temp_idx);

    return Card(
      child: ListTile(
        isThreeLine: true,
        title: Text(
          waste_obj.trashList[listItemMap.keys.first].koreaname,
          textScaleFactor: 1.5,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(listItemMap.values.first + "원", textScaleFactor: 1.3),
          ],
        ),
        trailing: IconButton(
          color: Colors.pinkAccent,
          icon: Icon(Icons.remove_circle),
          onPressed: () {
            setState(() {
              _selectedListItem.remove(listItemMap);
            });

            // 신청 목록에서 삭제시키면 가격도 같이 차감.
            int temp_index = waste_obj
                .trashList[listItemMap.keys.first].detailWaste
                .indexOf(listItemMap.values.first);
            args.totalPrice -= waste_obj
                .trashList[listItemMap.keys.first].wastePrice
                .elementAt(temp_index);
          },
        ),
      ),
    );
  }

  void _toggleButton(TrashListComfirmation_AccounSnapshot args) {
    setState(() {
      toggleValue = !toggleValue;
      List<String> myWasteKeys = new List();
      waste_obj.trashList.keys.forEach((String element) {
        myWasteKeys.add(element);
      });
      if (toggleValue) {
        _currentResult.clear();
        _currentResult.add("제품 목록을 선택하세요.");
        _currentResult.addAll(myWasteKeys);

        _dropDownMenuItems_Product =
            getDropDownMenuItems_Product(_currentResult);
        _currentProduct = _dropDownMenuItems_Product[0].value;
      } else {
        _currentResult.clear();
        _currentResult.add("제품 목록을 선택하세요.");
        _currentResult.addAll(args.myDeepLearningResultStr[args.current_Idx]);

        _dropDownMenuItems_Product =
            getDropDownMenuItems_Product(_currentResult);
        _currentProduct = _dropDownMenuItems_Product[0].value;
      }
    });
  }
}
