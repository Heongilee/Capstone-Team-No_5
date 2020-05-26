import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReservationDAO{
  final _db = Firestore.instance;
  QuerySnapshot _qs;
  List<ReservationDTO> _myReservationList;
  Map<String, dynamic> _myJsonObjects;
  // getter/setter
  List<ReservationDTO> get myReservationList => _myReservationList;
  Map<String, dynamic> get myJsonObjects => _myJsonObjects;
  set myJsonObjects(Map jsonObj) => _myJsonObjects = jsonObj;
  dynamic get loadMyReservation => _loadMyReservation();
  dynamic get accessMyFirestore => _accessMyFirestore();
  // ------------------------싱글톤 --------------------------------
  static final _instance = ReservationDAO._internal();

  factory ReservationDAO() {
    return _instance;
  }

  ReservationDAO._internal() {
    // 초기화 코드
    // _loadMyReservation();
  }
  // --------------------------------------------------------------

  Future<void> _loadMyReservation() async{
    _qs = await _db.collection('reservation').getDocuments();
    _qs.documents.forEach((DocumentSnapshot onValue) {
      _myReservationList.add(new ReservationDTO.fromJson(onValue.data));
    });

    return;
  }
  Future<void> _accessMyFirestore() async {
    var doc = await _db.collection('reservation').document().setData(myReservation._myJsonObjects);

    return;
  }
}
ReservationDAO myReservation = ReservationDAO();
class ReservationDTO {
    String reserveId;//사용자의 id
    DateTime reserveDate;//예약한 날짜
    DateTime reserveVisitDate;//선택한 방문 날짜
    String reserveVisitTime;//선택한 방문 시간
    String reserveAddress;//id의 주소
    List<dynamic> reserveItems;//선택한 물품
    String reserveState;//예약 상태

    ReservationDTO({
        this.reserveId,
        this.reserveDate,
        this.reserveVisitDate,
        this.reserveVisitTime,
        this.reserveAddress,
        this.reserveItems,
        this.reserveState,
    });

    factory ReservationDTO.fromJson(Map<String, dynamic> json) => ReservationDTO(
        reserveId: json["reserveId"],
        reserveDate: DateTime.parse(json["reserveDate"]),
        reserveVisitDate: DateTime.parse(json["reserveVisitDate"]),
        reserveVisitTime: json["reserveVisitTime"],
        reserveAddress: json["reserveAddress"],
        reserveItems: json["reserveItems"],
        reserveState: json["reserveState"],
    );

    Map<String, dynamic> toJson() => {
        "reserveId": reserveId,
        "reserveDate": "${reserveDate.year.toString().padLeft(4, '0')}-${reserveDate.month.toString().padLeft(2, '0')}-${reserveDate.day.toString().padLeft(2, '0')}",
        "reserveVisitDate": "${reserveVisitDate.year.toString().padLeft(4, '0')}-${reserveVisitDate.month.toString().padLeft(2, '0')}-${reserveVisitDate.day.toString().padLeft(2, '0')}",
        "reserveVisitTime": reserveVisitTime,
        "reserveAddress": reserveAddress,
        "reserveItems": reserveItems,
        "reserveState": reserveState,
    };
}