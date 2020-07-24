import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:recycle/model/AccountSnapshot.dart';

class ReservationDAO {
  final List<String> _reservationStateList = ["접수 완료", "방문 예정", "처리 완료"];
  final _db = Firestore.instance;
  QuerySnapshot _qs;
  List<ReservationDTO> _myReservationList;

  // getter/setter
  List<ReservationDTO> get myReservationList => _myReservationList;
  dynamic get loadMyReservation => _loadMyReservation();
  List<String> get reservationStateList => _reservationStateList;
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

  Future<void> _loadMyReservation() async {
    _qs = await _db.collection('reservation').getDocuments();
    _qs.documents.forEach((DocumentSnapshot onValue) {
      _myReservationList.add(new ReservationDTO.fromJson(onValue.data));
    });

    return;
  }

  // Firestore 'reservation' 컬렉션에 데이터 쓰기 시도.
  Future<void> insertReservation(Map myJsonObject) async {
    var doc =
        await _db.collection('reservation').document().setData(myJsonObject);

    return;
  }

  // Firestorage에 이미지를 업로드 해서 URL String이 담긴 리스트를 반환하는 메솓.
  Future<List<String>> uploadMyListViewItem(
      CustomerForm_AccountSnapshot args) async {
    List<String> _outputURL = [];

    var i = 0;
    for (File f in args.listViewItem) {
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('reserveImages')
          .child(
              '${args.currentAccount.data['id']}_${i++}_${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}(${DateTime.now().hour}${DateTime.now().minute}).png');
      final task = firebaseStorageRef.putFile(
          f, StorageMetadata(contentType: 'image/png'));

      await task.onComplete.then((StorageTaskSnapshot value) async {
        // 동적으로 생성된 정보이기 때문에 URI가 ref에 담겨져 있고,
        // 그 URI를 가지고 URL을 얻어 낸다. ( getDownloadURL() )

        // myDownloadURL는 Future 객체
        // var myDownloadURL = await value.ref.getDownloadURL();
        await value.ref.getDownloadURL().then((dynamic uri) {
          // uri.toString() 에 URL이 담김.
          _outputURL.add(uri.toString());
        });
      });
    }

    return _outputURL;
  }
}

ReservationDAO myReservation = ReservationDAO();

class ReservationDTO {
  String reserveId; //사용자의 id
  DateTime reserveDate; //예약한 날짜
  DateTime reserveVisitDate; //선택한 방문 날짜
  String reserveVisitTime; //선택한 방문 시간
  String reserveAddress; //id의 주소
  List<dynamic> reserveProducts; //선택한 물품
  List<dynamic> reserveDetails; //선택한 물품의 규격
  String reserveState; //예약 상태
  List<String> reserveFiles; //촬영된 사진
  String clientToken; //기기 토큰

  ReservationDTO({
    this.reserveId,
    this.reserveDate,
    this.reserveVisitDate,
    this.reserveVisitTime,
    this.reserveAddress,
    this.reserveProducts,
    this.reserveDetails,
    this.reserveState,
    this.reserveFiles,
    this.clientToken,
  });

  factory ReservationDTO.fromJson(Map<String, dynamic> json) => ReservationDTO(
        reserveId: json["reserveId"],
        reserveDate: DateTime.parse(json["reserveDate"]),
        reserveVisitDate: DateTime.parse(json["reserveVisitDate"]),
        reserveVisitTime: json["reserveVisitTime"],
        reserveAddress: json["reserveAddress"],
        reserveProducts: json["reserveProducts"],
        reserveDetails: json["reserveDetails"],
        reserveState: json["reserveState"],
        reserveFiles: json["reserveFiles"],
        clientToken: json["clientToken"],
      );

  Map<String, dynamic> toJson() => {
        "reserveId": reserveId,
        "reserveDate":
            "${reserveDate.year.toString().padLeft(4, '0')}-${reserveDate.month.toString().padLeft(2, '0')}-${reserveDate.day.toString().padLeft(2, '0')}",
        "reserveVisitDate":
            "${reserveVisitDate.year.toString().padLeft(4, '0')}-${reserveVisitDate.month.toString().padLeft(2, '0')}-${reserveVisitDate.day.toString().padLeft(2, '0')}",
        "reserveVisitTime": reserveVisitTime,
        "reserveAddress": reserveAddress,
        "reserveProducts": reserveProducts,
        "reserveDetails": reserveDetails,
        "reserveState": reserveState,
        "reserveFiles": reserveFiles,
        "clientToken": clientToken,
      };
}
