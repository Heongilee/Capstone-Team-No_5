# 생활폐기물 품목 측정 기술  
[![img](https://img.shields.io/badge/Flutter-v1.5.4--hotfix.2-blue)](https://flutter.dev/?gclsrc=aw.ds&&gclid=CjwKCAjwtNf6BRAwEiwAkt6UQl1UpD_-jdyv9qmwvzQcHupktDHZUpf1BmEN6MUMYir2CCqcDdB3jBoCqfAQAvD_BwE) [![img](https://img.shields.io/badge/Firebase-Firestore-red)](https://firebase.google.com/products/firestore?hl=ko) [![img](https://img.shields.io/badge/Firebase-Firestorage-red)](https://firebase.google.com/products/storage?hl=ko) [![img](https://img.shields.io/badge/Firebase-CloudMessaging-red)](https://firebase.google.com/products/cloud-messaging?hl=ko) [![img](https://img.shields.io/badge/Darknet-neural%20network%20framework-lightgrey)](https://github.com/pjreddie/darknet) ![img](https://img.shields.io/badge/NodeJS-v12.3.1-brightgreen)
   
2020 1학기 세종대학교 컴퓨터공학과 캡스톤 디자인 5조 


## 지도교수 :man:
안용학 교수님, 한동일 교수님

## 주제 :memo:
모바일 플랫폼 기반의 생활 폐기물 품목 측정 기술   
   
모바일 기반의 사용자가 스마트폰 카메라를 이용한 사물 촬영 시 객체 검출을 통해 우리 어플의 폐기물 분류 체계에서 대형 폐기물 중 어떤 항목에 해당 하는지 결과를 보여주고, 나온 결과를 토대로 폐기물 처리 진행을 도와주는 앱.

## 팀 멤버 :sparkles:
>팀 장 : 컴퓨터공학과 17013139 김영현   
>팀 원 : 컴퓨터공학과 17013149 정재웅   
>팀 원 : 컴퓨터공학과 17013146 위영민   
>팀 원 : 컴퓨터공학과 15012970 이헌기   
   
## 개발 일정 :running:
![개발_일정](https://github.com/Heongilee/Capstone-Team-No_5/blob/master/README_ASSET/Development_schedule.jpg?raw=true)
   
## 시스템 구성도 :+1:
![시스템 구성도](https://github.com/Heongilee/Capstone-Team-No_5/blob/master/README_ASSET/SystemConfigurationDiagram.jpg?raw=true)

## 시연 :iphone:
### 사진 불러오기
<img src="https://github.com/Heongilee/Capstone-Team-No_5/blob/master/README_ASSET/01.gif?raw=true" height="480"> <img src="https://github.com/Heongilee/Capstone-Team-No_5/blob/master/README_ASSET/02.gif?raw=true" height="480">   
   
대형 폐기물을 버리는 방식은 2가지 입니다. 미리 촬영된 이미지를 불러오거나, 즉석에서 폐기를 원하는 가구를 촬영할 수 있습니다.   
   
### 딥러닝 결과 확인
<img src="https://github.com/Heongilee/Capstone-Team-No_5/blob/master/README_ASSET/03.gif?raw=true" height="480">
   
이미지 첨부 완료 후 '다음'버튼을 누르면, 딥러닝 모델의 입력으로 넣은 결과(대형 폐기물 정보)를 가져옵니다.
   
### 제품 규격 선택 및 다중 객체 탐지 결과
<img src="https://github.com/Heongilee/Capstone-Team-No_5/blob/master/README_ASSET/04.gif?raw=true" height="480"> 
   
강남구청 대형 폐기물 기준에 맞춰 사용자가 분류 체계를 선택하면 가격이 산정됩니다.   
또한, 사진에 여러 객체가 있는 경우, 모두 탐지하여 제품 목록에 나타납니다.   
   
### 전체 리스트 조회
<img src="https://github.com/Heongilee/Capstone-Team-No_5/blob/master/README_ASSET/05.gif?raw=true" height="480">
   
만약, 원하는 결과 조회가 안됐을 경우 전체 리스트 조회 스위치를 ON 한 뒤 원하는 품목을 검색하면 됩니다.   
   
### 배출 신청
<img src="https://github.com/Heongilee/Capstone-Team-No_5/blob/master/README_ASSET/06.gif?raw=true" height="480">
   
방문수거 업자가 방문할 주소와 날짜, 시간을 선택 후 최종 산정 금액까지 확인이 끝나면 폐기물 배출 신청이 완료됩니다.
   
### 예약 조회
<img src="https://github.com/Heongilee/Capstone-Team-No_5/blob/master/README_ASSET/07.gif?raw=true" height="480">
   
예약된 내역은 '예약 조회' 탭에서 예약 내역 정보와 함께 조회가 가능합니다.
   
### 지자체에서 승인 시 사용자 장치로 푸시 알림
<img src="https://github.com/Heongilee/Capstone-Team-No_5/blob/master/README_ASSET/09.gif?raw=true" width="700"> <img src="https://github.com/Heongilee/Capstone-Team-No_5/blob/master/README_ASSET/08.gif?raw=true" height="480">
   
강남구청 사이트(모의 사이트)로 부터 승인이 떨어지면, 사용자 장치(모바일 기기)로 푸시 알람이 전송됩니다.

## 포스터 :rainbow:
![포스터](https://github.com/Heongilee/Capstone-Team-No_5/blob/master/README_ASSET/Poster.jpg?raw=true)
