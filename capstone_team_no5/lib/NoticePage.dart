import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoticeDAO {
  final _db = Firestore.instance;
  QuerySnapshot _qs;
}

class NoticeDTO with NoticeDAO {
  // ---------------- 싱글톤 패턴 코드 -------------------------
  static final NoticeDTO _instance = NoticeDTO._internal();

  NoticeDTO get instance => _instance;

  factory NoticeDTO() {
    return _instance;
  }

  NoticeDTO._internal() {
    // 리스트를 초기화 하고 다시 읽어 들인다.
    _noticeList.clear();
    loadMyNotice();
  }
  // ---------------------------------------------------------
  String _noticeTitle;
  String _noticeContent;
  dynamic _noticeDate;

  // 공지사항 개수만큼 이 곳에 쌓인다.
  List<NoticeDTO> _noticeList = [];

  // 공지사항을 전부 읽어들임.
  Future<void> loadMyNotice() async {
    _qs = await _db.collection('notice').getDocuments();
    _qs.documents.forEach((DocumentSnapshot notice_doc) {
      NoticeDTO obj = new NoticeDTO();
      obj._noticeTitle = notice_doc['noticeTitle'];
      obj._noticeContent = notice_doc['noticeContent'];
      obj._noticeDate = notice_doc['noticeDate'];

      _noticeList.add(obj);
    });

    return;
  }
}

class NoticePage extends StatefulWidget {
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
            myNotice.instance._noticeList.clear();
            Navigator.pop(context);
          }),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: ListView.separated(
              // padding: const EdgeInsets.all(16),
              itemCount: myNotice.instance._noticeList.length,
              itemBuilder: (BuildContext cont, int idx) {
                print('현재 ${myNotice._noticeList.length} 까지 읽어들였습니다.');
                return _buildRow(myNotice.instance._noticeList[idx], cont);

                // if (idx.isOdd) {
                //   return Divider();
                // } else {
                //   var _realIdx = idx ~/ 2;

                //   return _buildRow(myNotice.noticeList[_realIdx], context);
                // }
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
        ),
      ),
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
              title: Text(noticeList._noticeTitle, style: TextStyle()),
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
