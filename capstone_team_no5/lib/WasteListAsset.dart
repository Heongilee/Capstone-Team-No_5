import 'package:flutter/material.dart';

class WastePriceInfo {
  final List<String> _detailWaste;
  final List<int> _wastePrice;

  // getter
  List<String> get detailWaste => _detailWaste;
  List<int> get wastePrice => _wastePrice;

  WastePriceInfo(this._detailWaste, this._wastePrice);
}

class WasteListAsset {
  final Map<String, WastePriceInfo> _trashList = {
    "장롱": WastePriceInfo(['100cm이상 1쪽', '100cm미만 1쪽'], [15000, 10000]),
    "비키니 옷장": WastePriceInfo(['모든 규격'], [2000]),
    "장식장": WastePriceInfo(['100cm 이상', '100cm 미만'], [9000, 6000]),
    "문갑": WastePriceInfo(['100cm 이상', '100cm 미만'], [4000, 2000]),
    "서랍장": WastePriceInfo(['5단 이상', '4단 이하'], [5000, 3000]),
    "쇼파": WastePriceInfo(
        ['4인용 이상', '3인용', '2인용', '1인용'], [10000, 7000, 5000, 3000]),
    "식탁(테이블)": WastePriceInfo(
        ['4인용 이상', '3인용 이하', '5인용 이상(대리석)', '4인용 이하(대리석)'],
        [5000, 2000, 12000, 8000]),
    "싱크대": WastePriceInfo(['60cm 1짝당'], [3000]),
    "책상": WastePriceInfo(['양수책상', '편수책상', '컴퓨터용 책상, 서랍없음'], [7000, 4000, 3000]),
    "책장": WastePriceInfo(['100cm 이상', '100cm 미만'], [8000, 5000]),
    "책꽂이": WastePriceInfo(['4단 이하', '2단 이하'], [4000, 2000]),
    "침대": WastePriceInfo([
      '2인용 세트 (매트리스1개+틀)',
      '1인용 세트 (매트리스1개+틀)',
      '2인용(매트리스)',
      '1인용(매트리스)',
      '유아용 침대',
      '어린이 2층 침대',
      '2인용 돌침대 세트',
      '1인용 돌침대 세트'
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
    "의자": WastePriceInfo(
        ['1인용', '장의자', '바퀴달린의자(대형)', '바퀴달린의자(일반)'], [2000, 3000, 5000, 4000]),
    "화장대": WastePriceInfo(['모든규격'], [5000]),
    "신발장": WastePriceInfo(['1m이상', '1m미만'], [5000, 2000]),
    "옷걸이": WastePriceInfo(['모든 규격'], [2000]),
    "다림이판": WastePriceInfo(['모든 규격'], [1000]),
    "오디오장식장": WastePriceInfo(['모든 규격'], [3000]),
    "TV 받침": WastePriceInfo(['모든 규격'], [3000]),
    "밥상": WastePriceInfo(['4인 이상', '3인 이하'], [2000, 1000]),
    "진열대": WastePriceInfo(['모든 규격'], [3000]),
    "차탁자": WastePriceInfo(['모든 규격'], [2000]),
    "창문짝": WastePriceInfo(['모든규격'], [2000]),
    "문짝": WastePriceInfo(['목재류'], [3000]),
    "회의용 탁자":
        WastePriceInfo(['12인용 이상', '8인용 이상', '8인용 미만'], [9000, 7000, 5000]),
    "냉장고": WastePriceInfo(
        ['양문형 냉장고(700ℓ이상)', '양문형 냉장고(600ℓ이상)', '500ℓ이상', '300ℓ이상', '300ℓ미만'],
        [15000, 12000, 8000, 6000, 4000]),
    "김치냉장고": WastePriceInfo(['130ℓ 이상', '130ℓ 미만'], [5000, 3000]),
    "텔레비전": WastePriceInfo(
        ['42인치 이상', '25인치 이상', '25인치 미만', 'TV받침일체형(40인치 미만)'],
        [7000, 5000, 3000, 7000]),
    "세탁기": WastePriceInfo(['10kg 이상', '10kg 미만'], [5000, 3000]),
    "가스오븐렌지": WastePriceInfo(['높이 1m이상'], [5000]),
    "오디오": WastePriceInfo(['본체(높이 1m 이상)', '스피커(높이 1m 이상)'], [5000, 1000]),
    "에어컨": WastePriceInfo(['264㎡이상', '66㎡이상', '66㎡미만'], [8000, 5000, 3000]),
    "온풍기": WastePriceInfo(['264㎡이상', '66㎡이상', '66㎡미만'], [8000, 5000, 3000]),
    "공기청정기": WastePriceInfo(['높이 1m이상'], [5000]),
    "난로": WastePriceInfo(['석유난로'], [3000]),
    "정수기": WastePriceInfo(['높이 1m이상'], [5000]),
    "보일러": WastePriceInfo(['16,000cal/h이상', '16,000cal/h미만'], [12000, 8000]),
    "자동판매기": WastePriceInfo(['음료, 담배 등', '자가, 소형'], [15000, 3000]),
    "선풍기": WastePriceInfo(['업소용(대형)'], [3000]),
    "환풍기": WastePriceInfo(['업소용', '가정용'], [3000, 2000]),
    "피아노": WastePriceInfo(['일반', '디지털(오르간 포함)'], [15000, 5000]),
    "쌀통": WastePriceInfo(['모든규격'], [3000]),
    "액자": WastePriceInfo(
        ['높이 1m이상', '높이 50cm~1m', '높이 50cm 미만'], [3000, 2000, 1000]),
    "시계": WastePriceInfo(['높이 1m이상'], [3000]),
    "장판": WastePriceInfo(['3.3㎡당'], [2000]),
    "카페트": WastePriceInfo(['3.3㎡당'], [2000]),
    "이불": WastePriceInfo(['모든규격'], [2000]),
    "캐비넷": WastePriceInfo(['모든규격'], [4000]),
    "화일캐비넷": WastePriceInfo(['4단 이상', '4단 미만'], [4000, 3000]),
    "어항": WastePriceInfo(['2m 이상', '1m 이상', '1m 미만'], [9000, 5000, 3000]),
    "변기": WastePriceInfo(['양변기', '좌변기'], [8000, 5000]),
    "세면대": WastePriceInfo(['모든 규격'], [3000]),
    "욕조": WastePriceInfo(['일반용', '유아용'], [5000, 3000]),
    "유리(거울,판유리)": WastePriceInfo(['1㎡당'], [2000]),
    "기타 목재": WastePriceInfo(['5kg 당'], [2000]),
    "기타 프라스틱류": WastePriceInfo(['5kg 당'], [2000]),
    "화분": WastePriceInfo(['높이 50cm이상', '높이 50cm미만'], [2000, 1000]),
    "유모차(보행기)": WastePriceInfo(['모든규격'], [3000]),
    "인형, 장난감류": WastePriceInfo(['대형(미끄럼틀, 놀이집 등)', '소형(3kg당)'], [2000, 1000]),
    "자전거": WastePriceInfo(['성인용', '아동용(2륜)', '아동용(3륜)'], [3000, 3000, 2000]),
    "항아리": WastePriceInfo(
        ['100ℓ 이상(대형)', '100ℓ 미만(중형)', '30ℓ 미만(소형)'], [5000, 3000, 2000]),
    "가방류": WastePriceInfo(
        ['골프 가방', '가로 50cm 이상', '가로 50cm 미만'], [3000, 3000, 2000]),
    "쓰레기통": WastePriceInfo(['사무실용, 옥외용', '가정용'], [2000, 1000]),
    "목욕탕 수건함": WastePriceInfo(['모든 규격'], [1000]),
    "재봉틀": WastePriceInfo(['모든 규격'], [2000]),
    "고무통": WastePriceInfo(
        ['지름100cm이상', '지름50cm이상', '지름50cm미만'], [5000, 3000, 2000]),
    "병풍": WastePriceInfo(['2폭당'], [1000]),
    "러닝머신": WastePriceInfo(['모든 규격'], [10000]),
    "빨래건조대": WastePriceInfo(['모든 규격'], [2000]),
    "옥매트": WastePriceInfo(['2인용', '1인용'], [7000, 4000]),
    "배기후드": WastePriceInfo(['모든 규격'], [2000]),
    "아이스박스": WastePriceInfo(['대형', '소형'], [2000, 1000]),
    "스키": WastePriceInfo(['모든 규격'], [2000]),
    "보드": WastePriceInfo(['모든 규격'], [2000])
  };

  // getter
  Map<String, WastePriceInfo> get trashList => _trashList;
}
