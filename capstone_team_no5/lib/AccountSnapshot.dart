import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/* ----------------------------------------------------------------------------
                    ※ 페이지로 인자 전달하는 방법. ※
  1. AccountSnapshot을 상속받는 [페이지명]_AccountSnapshot 클래스를 생성하기.

  2. _currentAccount(DocumentSnapshot 타입) 이외에 전달하고 싶은 인자를 명시

  3. 생성자 Generating.

  4. [페이지명].dart로 가서 다음을 추가.
    static const routeName = '/TakingPicture';

    ...
    final TakingPicture_AccountSnapshot args = ModalRoute.of(context).settings.arguments;

  5. main.dart에 가서 다음을 추가.
    [페이지명].routeName: (context) => [페이지명](),

  
  6. 전달받은 인자를 사용할 때는 args.~~ 로 접근할 것.
---------------------------------------------------------------------------- */
class AccountSnapshot {
  final DocumentSnapshot _currentAccount;

  DocumentSnapshot get currentAccount => _currentAccount;

  AccountSnapshot(this._currentAccount);
}

class TakingPicture_AccountSnapshot extends AccountSnapshot {
  TakingPicture_AccountSnapshot(DocumentSnapshot currentAccount)
      : super(currentAccount);
}

class TrashListComfirmation_AccounSnapshot extends AccountSnapshot {
  List<File> _listViewItem; // 이미지 파일 리스트
  final current_Idx; // 현재 페이지 인덱스
  Map<int, List<String>>
      _myDeepLearningResultStr; // int번째 인덱스의 딥러닝 다중 검출 결과 List<String>
  Set<Map<String, String>> _selectedListItem; // 사용자가 선택한 _selectedListItem
  int _totalPrice; // 사용자가 선택한 폐기물 토탈 처리 비용.

  // getter
  Set<Map<String, String>> get selectedListItem => _selectedListItem;
  List<File> get listViewItem => _listViewItem;
  Map<int, List<String>> get myDeepLearningResultStr =>
      _myDeepLearningResultStr;
  int get totalPrice => _totalPrice;
  set totalPrice(int totalPrice) => this._totalPrice = totalPrice;

  TrashListComfirmation_AccounSnapshot(
      DocumentSnapshot currentAccount,
      this._listViewItem,
      this.current_Idx,
      this._myDeepLearningResultStr,
      this._selectedListItem,
      this._totalPrice)
      : super(currentAccount); // 현재 출력중인 페이지 번호 0 ~ [사진 갯수-1] 만큼
}

class CustomerForm_AccountSnapshot extends AccountSnapshot {
  List<File> _listViewItem; // 이미지 파일 리스트
  int _totalPrice; // 사용자가 선택한 폐기물 토탈 처리 비용.
  Set<Map<String, String>> _selectedListItem; // 사용자가 선택한 _selectedListItem
  /*
  {
    {"어항", "2m"},
    {""}
  }
  */

  // getter
  List<File> get listViewItem => _listViewItem;
  Set<Map<String, String>> get selectedListItem => _selectedListItem;
  int get totalPrice => _totalPrice;
  set totalPrice(int totalPrice) => this._totalPrice = totalPrice;

  CustomerForm_AccountSnapshot(DocumentSnapshot currentAccount,
      this._listViewItem, this._selectedListItem, this._totalPrice)
      : super(currentAccount);
}

class TabPage_AccountSnapshot extends AccountSnapshot {
  TabPage_AccountSnapshot(DocumentSnapshot currentAccount)
      : super(currentAccount);
}
