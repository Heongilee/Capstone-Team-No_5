import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/model/NoticeModel.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  void initState() {
    super.initState();
    // * 중요! : 스트림 컨트롤러를 싱글톤 클래스 안에 넣고, initState에서 초기화 시킨 다음에 불러오고 true로 바꿀 것.
    myNotice.noticeObserver = StreamController<bool>()..add(false);
    myNotice.loadmyNotice;
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
            myNotice.noticeObserver.add(false);
            Navigator.pop(context);
          }),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: StreamBuilder<bool>(
            stream: myNotice.noticeObserver.stream,
            builder: (context, snapshot) {
              if (snapshot.data) {
                // 로드 완료
                return _buildMyRefreshIndicator();
              } else {
                return _myCircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Widget _myCircularProgressIndicator() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      itemCount: myNotice.myNoticeList.length * 2,
      itemBuilder: (BuildContext context, int index) {
        if (index.isOdd)
          return Divider();
        else {
          var realIndex = index ~/ 2;

          return _buildRow(myNotice.myNoticeList[realIndex]);
        }
      },
    );
  }

  Widget _buildRow(NoticeDTO noticeList) {
    return ListTile(
      leading: null,
      trailing: Icon(Icons.keyboard_arrow_down),
      title: Text(noticeList.noticeTitle,
          textScaleFactor: 1.5, style: TextStyle()),
      subtitle: Text(noticeList.noticeContent.substring(0, 25) + "...",
          style: TextStyle()),
      dense: true,
      onTap: () {
        // 제목 : noticeList.noticeTitle
        // 내용 : noticeList.noticeContent
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(noticeList.noticeTitle,
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.2),
              content: Text(noticeList.noticeContent, style: TextStyle()),
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

  Widget _buildMyRefreshIndicator() {
    return RefreshIndicator(
      onRefresh: () async {
        myNotice.myNoticeList.clear();

        myNotice.qs = await myNotice.db.collection('notice').getDocuments();
        setState(() {
          myNotice.qs.documents.forEach((DocumentSnapshot onValue) {
            myNotice.myNoticeList.add(new NoticeDTO.fromJson(onValue.data));
          });
        });
      },
      child: _buildList(context),
    );
  }
}
