import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/ReservationDTO.dart';

class ReservationList extends StatelessWidget {
  final _db = Firestore.instance;
  QuerySnapshot _qs;
  final DocumentSnapshot _currentAccount;
  // 로그인 세션
  ReservationList(this._currentAccount);
  // 예약 목록의 리스트 개수.
  final _itemsize = 20;
  // 대형 폐기물 상태 리스트.
  final _statusList = ["Processing...", "Receipt completed", "Done"];

  // dataColumn_List
  List<DataColumn> dataColumn = [];
  List<DataRow> dataRow = []; // TODO : 이놈 정렬 해야한다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          '예약 조회',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),
    );
  }

  // Table 위젯 이용.
  Widget _buildBody() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: StreamBuilder<QuerySnapshot>(
              stream: _db.collection('reservation').snapshots(),
              builder: (context, snapshot) {
                  List<DataCell> myreturnList = [];
                  final students = snapshot.data.documents;
                    students.forEach((element) {
                     myreturnList.add(DataCell(Text('${element['reserveVisitDate']}')));
                     myreturnList.add(DataCell(Text('${element['reserveVisitTime']}')));
                     myreturnList.add(DataCell(Text('${element['reserveState']}')));
                  });
                  dataRow.add(DataRow(cells: myreturnList));
                return _getDataTable();
              }
            ),
          ),
        ),
      ),
    );
  }

  Widget _getDataTable() {
    dataColumn.clear();
    dataRow.clear();

    return DataTable(
      // TODO : https://stackoverflow.com/questions/51434778/flutter-using-datatable-sorting-built-in-function
      // TODO : 스택 오버플로우 사이트 참고해서 Sorting 익히기.
      sortColumnIndex: 0,
      sortAscending: true,
      horizontalMargin: 12.0,
      columnSpacing: 24.0,
      columns: _getDataColumns(),
      rows: _getDataRows(_itemsize),
    );
  }

  List<DataColumn> _getDataColumns() {
    dataColumn.add(DataColumn(
        numeric: true,
        label: Text(
          '예약 날짜',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 16.0),
          textAlign: TextAlign.center,
        )));
    dataColumn.add(DataColumn(
        label: Text(
      '상태',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: 16.0),
      textAlign: TextAlign.center,
    )));

    dataColumn.add(DataColumn(
        label: Text(
      '방문 날짜',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontSize: 16.0),
      textAlign: TextAlign.center,
    )));

    //     dataColumn.add(DataColumn(
    //     label: Text(
    //   '방문 시간',
    //   style: TextStyle(
    //       fontWeight: FontWeight.bold,
    //       fontStyle: FontStyle.italic,
    //       fontSize: 16.0),
    //   textAlign: TextAlign.center,
    // )));

    print(dataColumn.length);
    return dataColumn;
  }

  List<DataRow> _getDataRows(int row_number) {
    _accessMyReservationList(); 
    return dataRow;
  }

  Future<List<DataCell>>_accessMyReservationList() async{
    List<DataCell> myreturnList = [];
    _qs = await _db.collection('reservation').where("reserveId", isEqualTo: _currentAccount['id'])
    .getDocuments();
    _qs.documents.forEach((element) {
      myreturnList.add(DataCell(Text('${element['reserveVisitDate']}')));
      myreturnList.add(DataCell(Text('${element['reserveVisitTime']}')));
      myreturnList.add(DataCell(Text('${element['reserveState']}')));
     });
     dataRow.add(DataRow(cells: myreturnList));
  }

  
}
