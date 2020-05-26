import 'package:flutter/material.dart';
import 'package:recycle/model/NoticeModel.dart';

class NoticePage extends StatefulWidget{
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
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
            Navigator.pop(context);
          }),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          // child: StreamBuilder<QuerySnapshot>(
          //     stream: myNotice.db.collection('notice').snapshots(),
          //     builder: (context, snapshot) {
          //       if (!snapshot.hasData)
          //         return _myCircularProgressIndicator();
          //       else
          //         return _buildList(context);
          //     }),
          child: RefreshIndicator(
            onRefresh: () => myNotice.loadmyNotice,
            child: _buildList(context), 
          ),
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
}
