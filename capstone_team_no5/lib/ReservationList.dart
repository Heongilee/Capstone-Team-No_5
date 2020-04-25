import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReservationList extends StatelessWidget {
  // 로그인 세션
  final DocumentSnapshot account_session;
  ReservationList(this.account_session);
  // 예약 목록의 리스트 개수.
  final _itemsize = 50;
  // 대형 폐기물 상태 리스트.
  final _statusList = ["Processing...", "Receipt completed", "Done"];

  // dataColumn_List
  List<DataColumn> dataColumn = [];
  bool sorted_dataColumn = false;
  // dataRow_List
  List<DataRow> dataRow = [];   // TODO : 이놈 정렬 해야한다.
  bool sorted_dataRow = false;

  void onSort(int col_Idx, bool asc){
    if(col_Idx == 0){
      if(asc){
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('예약 조회', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
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
            child: _getDataTable(),
          ),
        ),
      ),
    );
  }

  Widget _getDataTable() {
    return DataTable(
      // TODO : https://stackoverflow.com/questions/51434778/flutter-using-datatable-sorting-built-in-function
      // TODO : 스택 오버플로우 사이트 참고해서 Sorting 익히기.
      sortColumnIndex: 0,
      sortAscending: true,
      horizontalMargin: 12.0,
      columnSpacing: 28.0,
      columns: _getDataColumns(),
      rows: _getDataRows(_itemsize),
    );
  }
  
  List<DataColumn> _getDataColumns(){
    dataColumn.add(DataColumn(numeric: true, label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 16.0),textAlign: TextAlign.center,)));
    dataColumn.add(DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 16.0),textAlign: TextAlign.center,)));

    return dataColumn;
  }
  List<DataRow> _getDataRows(int row_number){
    var _year = 2000;

    for(int i = 0; i < row_number;i++){
      List<DataCell> cells = [];
      cells.add(DataCell(Text('$_year-01-01')));
      cells.add(DataCell(Text(_statusList[i % 3])));

      dataRow.add(DataRow(cells: cells));
      _year++;
    }

    return dataRow;
  }
}