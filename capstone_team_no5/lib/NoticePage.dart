import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoticeDAO {
  final _db = Firestore.instance;
  QuerySnapshot _qs;
}

class NoticeDTO with NoticeDAO {
  // ---------------- 싱글톤 패턴 코드 -------------------------
  static final NoticeDTO _instance = NoticeDTO._internal();

  factory NoticeDTO() {
    return _instance;
  }

  NoticeDTO._internal() {
    // 리스트를 초기화 하고 다시 읽어 들인다.
    _noticeList.clear();
    // loadMyNotice();
  }
  // ---------------------------------------------------------
  String _noticeTitle;
  String _noticeContent;
  dynamic _noticeDate;

  // 공지사항 개수만큼 이 곳에 쌓인다.
  List<NoticeDTO> _noticeList = new List();
}

class NoticePage extends StatefulWidget with NoticeDAO {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  NoticeDTO myNotice;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myNotice = new NoticeDTO();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text(
        '공지사항',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            NoticeDTO()._noticeList.clear();
            Navigator.pop(context);
          }),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
              stream: widget._db.collection('notice').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return _myCircularProgressIndicator();
                else
                  return _buildList(context, snapshot.data.documents);
              }),
        ),
      ),
    );
  }

  Widget _myCircularProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (index.isOdd)
          return Divider();
        else {
          var realIndex = index ~/ 2;

          return _buildRow(NoticeDTO()._noticeList[realIndex], context);
        }
      },
    );
  }

  Widget _buildRow(NoticeDTO noticeList, BuildContext context) {
    return ListTile(
      leading: null,
      trailing: Icon(Icons.keyboard_arrow_down),
      title: Text(noticeList._noticeTitle,
          textScaleFactor: 1.5, style: TextStyle()),
      subtitle: Text(noticeList._noticeContent.substring(0, 25) + "...",
          style: TextStyle()),
      dense: true,
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(noticeList._noticeTitle,
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.2),
              content: Text(noticeList._noticeContent, style: TextStyle()),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('닫 기')),
              ],
            );
          },
        );
      },
    );
  }
}
