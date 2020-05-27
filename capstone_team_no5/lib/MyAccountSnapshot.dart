import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyAccountSnapshot {
  final DocumentSnapshot _currentAccount;
  List<File> listViewItem; // 이미지 파일 리스트
  int current_Idx; // 현재 출력중인 페이지 번호 0 ~ [사진 갯수-1] 만큼

  MyAccountSnapshot(this._currentAccount,
      {this.listViewItem, this.current_Idx});
}
