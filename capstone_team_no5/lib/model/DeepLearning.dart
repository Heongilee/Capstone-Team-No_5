import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


// TODO : 딥러닝 클래스 만들기!! (200610 (15:08))
const PROTOCOL = "http";
const IP_ADDRESS = "15.164.123.37";
const PORT = "3000";
const ROUTE = "image";
const API_PREFIX = "$PROTOCOL://$IP_ADDRESS:$PORT/$ROUTE";

class DeepLearning {
  // 싱글톤 로직 ---------------------------------------------
  static final DeepLearning _instance = new DeepLearning.internal();
  
  factory DeepLearning() {
    return _instance;
  }
  
  DeepLearning.internal(){
    // 초기화 코드...
  }
  // --------------------------------------------------------
  List<File> listViewItem;  // 다중 이미지 리스트 혹은 단일 이미지 객체.
  
    // 딥러닝 결과를 받아올 메소드
  Future<Map<int, List<String>>> _loadMyDeepLearningModule(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '딥러닝 분석 결과가 나올 때 까지\n 잠시만 기다려 주세요...',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
          content: CircularProgressIndicator(), // TODO : SizedBox로 감싸면 줄어듦.
        );
      },
    );

    Map<int, List<String>> _myDeepLearningResults = {
      // 0: ["시계"], // 0번째 사진에서 검출된 객체들은 어항, 이불, 화분, 자전거, 항아리가 있다.
      // 1: ["가방류", "고무통", "러닝머신", "옥매트"], // 1번째 사진에서 검출된 객체들은 다음과 같다.
      // 2: ["유리(거울,판유리)", "재봉틀", "화일캐비넷", "피아노", "환풍기", "카페트"],
      // 3: ["어항", "이불", "화분", "자전거", "항아리"], // 0번째 사진에서 검출된 객체들은 어항, 이불, 화분, 자전거, 항아리가 있다.
      // 4: ["가방류", "고무통", "러닝머신", "옥매트"], // 1번째 사진에서 검출된 객체들은 다음과 같다.
      // 5: ["유리(거울,판유리)", "재봉틀", "화일캐비넷", "피아노", "환풍기", "카페트"]
    };

    // !-------------------- AWS EC2 서버 가동중일때만 가능. ---------------------
    int tmp_idx;
    String tmp; // res.body를 받아올 임시 변수
    for (File element in myDL.listViewItem) {
      final String nodeEndPoint = API_PREFIX;

      if (element == null) {
        print("어 파일인식 안됨");
        break;
      }
      String base64Image = base64Encode(element.readAsBytesSync());
      String fileName = element.path.split("/").last;

      print("파일이름 : " + fileName);

      await http.post(nodeEndPoint, body: {
        "image": base64Image,
        "name": fileName,
      }).then((res) {
        print(res.body);
        print("상태코드 : ");
        print(res.statusCode);
        tmp = res.body;

        List<String> response_list = tmp.split(",");
        _myDeepLearningResults.addAll({_myDeepLearningResults.length: response_list});
      }).catchError((err) {
        print(err);
      });
    }
    // !------------------------------------------------------------------------

    return _myDeepLearningResults;
  }
}
DeepLearning myDL = new DeepLearning();
