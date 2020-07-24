import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeDAO {
  var noticeObserver = StreamController<bool>.broadcast();
  // * ------------------------ 싱글톤  로직 ------------------------
  static final NoticeDAO _instance = NoticeDAO._internal();

  factory NoticeDAO() {
    return _instance;
  }

  NoticeDAO._internal() {}
  // *-------------------------------------------------------------
  final _db = Firestore.instance;
  QuerySnapshot _qs;
  List<NoticeDTO> _myNoticeList = [
    NoticeDTO(
        noticeTitle: "Dummy-Title",
        noticeContent: "Dummy-Content",
        noticeDate: DateTime.now())
  ];
  // getter
  Firestore get db => _db;
  QuerySnapshot get qs => _qs;
  set qs(QuerySnapshot _qs) => this._qs = _qs;
  List<NoticeDTO> get myNoticeList => _myNoticeList;
  Future<Null> get loadmyNotice => _loadmyNotice();

  Future<Null> _loadmyNotice() async {
    _myNoticeList.clear();

    _qs = await _db.collection('notice').getDocuments();
    _qs.documents.forEach((DocumentSnapshot onValue) {
      _myNoticeList.add(new NoticeDTO.fromJson(onValue.data));
    });

    noticeObserver.add(true);
  }
}

// * 싱글톤 인스턴스(NoticeDAO)
NoticeDAO myNotice = NoticeDAO();

class NoticeDTO {
  String noticeTitle;
  String noticeContent;
  DateTime noticeDate;

  NoticeDTO({
    this.noticeTitle,
    this.noticeContent,
    this.noticeDate,
  });

  factory NoticeDTO.fromJson(Map<String, dynamic> json) => NoticeDTO(
        noticeTitle: json["noticeTitle"],
        noticeContent: json["noticeContent"],
        // noticeDate: DateTime.parse(json["noticeDate"]),
        noticeDate: (json["noticeDate"] as Timestamp).toDate(),
        // noticeDate: new DateTime.fromMicrosecondsSinceEpoch(json["noticeDate"] * 1000),
      );

  Map<String, dynamic> toJson() => {
        "noticeTitle": noticeTitle,
        "noticeContent": noticeContent,
        "noticeDate": Timestamp.fromDate(noticeDate),
      };
}
