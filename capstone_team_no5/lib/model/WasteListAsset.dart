import 'package:flutter/material.dart';

class WastePriceInfo {
  String _koreaName;
  final List<String> _detailWaste;
  final List<int> _wastePrice;

  // getter
  String get koreaname => _koreaName;
  List<String> get detailWaste => _detailWaste;
  List<int> get wastePrice => _wastePrice;

  WastePriceInfo(this._koreaName, this._detailWaste, this._wastePrice);
}

class WasteListAsset {
  // ------------------------------- 싱글톤 로직 ---------------------------------------
  static final WasteListAsset _instance = new WasteListAsset._internal();

  factory WasteListAsset() {
    return _instance;
  }

  WasteListAsset._internal() {}
  // -----------------------------------------------------------------------------------
  final Map<String, WastePriceInfo> _trashList = {
    "wardrobe":
        WastePriceInfo("장롱", ['100cm이상 1쪽- 15000', '100cm미만 1쪽- 10000'], [15000, 10000]),
    "Bikini_closet": WastePriceInfo("비키니 옷장", ['모든 규격- 2000'], [2000]),
    "cabineettt": WastePriceInfo("장식장", ['100cm 이상- 9000', '100cm 미만- 6000'], [9000, 6000]),
    "Moonlight": WastePriceInfo("문갑", ['100cm 이상- 4000', '100cm 미만- 2000'], [4000, 2000]),
    "chiffonier": WastePriceInfo("서랍장", ['5단 이상- 5000', '4단 이하- 3000'], [5000, 3000]),
    "sofa": WastePriceInfo(
        "쇼파", ['4인용 이상- 10000', '3인용- 7000', '2인용- 5000', '1인용- 3000'], [10000, 7000, 5000, 3000]),
    "table": WastePriceInfo(
        "식탁(테이블)",
        ['4인용 이상- 5000', '3인용 이하- 2000', '5인용 이상(대리석)- 12000', '4인용 이하(대리석)- 8000'],
        [5000, 2000, 12000, 8000]),
    "sink": WastePriceInfo("싱크대", ['60cm 1짝당- 3000'], [3000]),
    "Desk": WastePriceInfo(
        "책상", ['양수책상- 7000', '편수책상- 4000', '컴퓨터용 책상, 서랍없음- 3000'], [7000, 4000, 3000]),
    "bookshelf": WastePriceInfo("책장(책꽂이)",
        ['100cm 이상- 8000', '100cm 미만-5 000', '4단 이하- 4000', '2단 이하- 2000'], [8000, 5000, 4000, 2000]),
    // "책꽂이": WastePriceInfo(['4단 이하', '2단 이하'], [4000, 2000]),
    "bed": WastePriceInfo("침대", [
      '2인용 세트 (매트리스1개+틀)- 15000',
      '1인용 세트 (매트리스1개+틀)- 10000',
      '2인용(매트리스)- 8000',
      '1인용(매트리스)- 5000',
      '유아용 침대- 3000',
      '어린이 2층 침대- 20000',
      '2인용 돌침대 세트- 30000',
      '1인용 돌침대 세트- 25000'
    ], [
      15000,
      10000,
      8000,
      5000,
      3000,
      20000,
      30000,
      25000
    ]),
    "chair": WastePriceInfo("의자", ['1인용- 2000', '장의자- 3000', '바퀴달린의자(대형)- 5000', '바퀴달린의자(일반)- 4000'],
        [2000, 3000, 5000, 4000]),
    "Dressing_table": WastePriceInfo("화장대", ['모든규격- 5000' ], [5000]),
    "shoe_closet": WastePriceInfo("신발장", ['1m이상- 5000', '1m미만- 2000'], [5000, 2000]),
    "hanger": WastePriceInfo("옷걸이", ['모든 규격- 2000'], [2000]),
    "Ironing_board": WastePriceInfo("다림이판", ['모든 규격- 1000'], [1000]),
    "Audio_bench": WastePriceInfo("오디오장식장", ['모든 규격- 3000'], [3000]),
    "TV_stand": WastePriceInfo("TV 받침", ['모든 규격- 3000'], [3000]),
    "foodDesk": WastePriceInfo("밥상", ['4인 이상- 2000', '3인 이하- 1000'], [2000, 1000]),
    "Display_stand": WastePriceInfo("진열대", ['모든 규격- 3000'], [3000]),
    "Charterer": WastePriceInfo("차탁자", ['모든 규격- 2000'], [2000]),
    "windowdoor": WastePriceInfo("창문짝", ['모든규격- 2000'], [2000]),
    "doorframe": WastePriceInfo("문짝", ['목재류- 3000'], [3000]),
    "meetingtable": WastePriceInfo(
        "회의용 탁자", ['12인용 이상- 9000', '8인용 이상- 7000', '8인용 미만- 5000'], [9000, 7000, 5000]),
    "refrigerator": WastePriceInfo(
        "냉장고",
        ['양문형 냉장고(700ℓ이상)- 15000', '양문형 냉장고(600ℓ이상)- 12000', '500ℓ이상- 8000', '300ℓ이상- 6000', '300ℓ미만- 4000'],
        [15000, 12000, 8000, 6000, 4000]),
    "kimchirefri":
        WastePriceInfo("김치냉장고", ['130ℓ 이상- 5000', '130ℓ 미만- 3000'], [5000, 3000]),
    "television": WastePriceInfo(
        "텔레비전",
        ['42인치 이상- 7000', '25인치 이상- 5000', '25인치 미만- 3000', 'TV받침일체형(40인치 미만)- 7000'],
        [7000, 5000, 3000, 7000]),
    "laundry": WastePriceInfo("세탁기", ['10kg 이상- 5000', '10kg 미만- 3000'], [5000, 3000]),
    "gaslange ": WastePriceInfo("가스오븐렌지", ['높이 1m이상- 5000'], [5000]),
    "audio":
        WastePriceInfo("오디오", ['본체(높이 1m 이상)- 5000', '스피커(높이 1m 이상)- 1000'], [5000, 1000]),
    "aircondition":
        WastePriceInfo("에어컨", ['264㎡이상- 8000', '66㎡이상- 5000', '66㎡미만- 3000'], [8000, 5000, 3000]),
    "hotfan":
        WastePriceInfo("온풍기", ['264㎡이상- 8000', '66㎡이상- 5000', '66㎡미만- 3000'], [8000, 5000, 3000]),
    "airclean": WastePriceInfo("공기청정기", ['높이 1m이상- 5000'], [5000]),
    "heater": WastePriceInfo("난로", ['석유난로- 3000'], [3000]),
    "water": WastePriceInfo("정수기", ['높이 1m이상- 5000'], [5000]),
    "boiler": WastePriceInfo(
        "보일러", ['16,000cal/h이상- 12000', '16,000cal/h미만- 8000'], [12000, 8000]),
    "autostaller":
        WastePriceInfo("자동판매기", ['음료, 담배 등- 15000', '자가, 소형- 3000'], [15000, 3000]),
    "bigfan": WastePriceInfo("선풍기", ['업소용(대형)- 3000'], [3000]),
    "ventilator": WastePriceInfo("환풍기", ['업소용- 3000', '가정용- 2000'], [3000, 2000]),
    "piano": WastePriceInfo("피아노", ['일반- 15000', '디지털(오르간 포함)- 5000'], [15000, 5000]),
    "ricebox": WastePriceInfo("쌀통", ['모든규격- 3000'], [3000]),
    "frame": WastePriceInfo(
        "액자", ['높이 1m이상- 3000', '높이 50cm~1m- 2000', '높이 50cm 미만- 1000'], [3000, 2000, 1000]),
    "clock": WastePriceInfo("시계", ['높이 1m이상- 3000'], [3000]),
    "floor": WastePriceInfo("장판", ['3.3㎡당- 2000'], [2000]),
    "carpet": WastePriceInfo("카페트", ['3.3㎡당- 2000'], [2000]),
    "blanket": WastePriceInfo("이불", ['모든규격- 2000'], [2000]),
    "cabinet": WastePriceInfo("캐비넷", ['모든규격- 4000'], [4000]),
    "filecabinet": WastePriceInfo("화일캐비넷", ['4단 이상- 4000', '4단 미만- 3000'], [4000, 3000]),
    "a_fishing_port":
        WastePriceInfo("어항", ['2m 이상- 9000', '1m 이상- 5000', '1m 미만- 3000'], [9000, 5000, 3000]),
    "Toilet": WastePriceInfo("변기", ['양변기- 8000', '좌변기- 5000'], [8000, 5000]),
    "Basin": WastePriceInfo("세면대", ['모든 규격- 3000'], [3000]),
    "Bathhub": WastePriceInfo("욕조", ['일반용- 5000', '유아용- 3000'], [5000, 3000]),
    "glass": WastePriceInfo("유리(거울,판유리)", ['1㎡당- 2000'], [2000]),
    "wood": WastePriceInfo("기타 목재", ['5kg 당- 2000'], [2000]),
    "plastic": WastePriceInfo("기타 플라스틱류", ['5kg 당- 2000'], [2000]),
    "Flowerpot": WastePriceInfo("화분", ['높이 50cm이상- 2000', '높이 50cm미만- 1000'], [2000, 1000]),
    "stroller": WastePriceInfo("유모차(보행기)", ['모든규격- 3000'], [3000]),
    "toys_and_other": WastePriceInfo(
        "인형,장난감류", ['대형(미끄럼틀, 놀이집 등)- 2000', '소형(3kg당)- 1000'], [2000, 1000]),
    "Bicycle ": WastePriceInfo(
        "자전거", ['성인용- 3000', '아동용(2륜)- 3000', '아동용(3륜)- 2000'], [3000, 3000, 2000]),
    "jar": WastePriceInfo("항아리", ['100ℓ 이상(대형)- 5000', '100ℓ 미만(중형)- 3000', '30ℓ 미만(소형)- 2000'],
        [5000, 3000, 2000]),
    "bag": WastePriceInfo(
        "가방류", ['골프 가방- 3000', '가로 50cm 이상- 3000', '가로 50cm 미만- 2000'], [3000, 3000, 2000]),
    "a_trash_can": WastePriceInfo("쓰레기통", ['사무실용, 옥외용- 2000', '가정용- 1000'], [2000, 1000]),
    "bathroom_dryness": WastePriceInfo("목욕탕 수건함", ['모든 규격- 1000'], [1000]),
    "sewing_machine": WastePriceInfo("재봉틀", ['모든 규격- 2000'], [2000]),
    "a_rubber_basin": WastePriceInfo(
        "고무통", ['지름100cm이상- 5000', '지름50cm이상- 3000', '지름50cm미만- 2000'], [5000, 3000, 2000]),
    "a_folding_screen": WastePriceInfo("병풍", ['2폭당- 1000'], [1000]),
    "running_machine ": WastePriceInfo("러닝머신", ['모든 규격- 10000'], [10000]),
    "a_clothes_horse": WastePriceInfo("빨래건조대", ['모든 규격- 2000'], [2000]),
    "a_jade_mat": WastePriceInfo("옥매트", ['2인용- 7000', '1인용- 4000'], [7000, 4000]),
    "exhaust_hood": WastePriceInfo("배기후드", ['모든 규격- 2000'], [2000]),
    "icebox": WastePriceInfo("아이스박스", ['대형- 2000', '소형- 1000'], [2000, 1000]),
    "skis": WastePriceInfo("스키", ['모든 규격- 2000'], [2000]),
    "snowboard": WastePriceInfo("보드", ['모든 규격- 2000'], [2000])
  };

  // getter
  Map<String, WastePriceInfo> get trashList => _trashList;
}
