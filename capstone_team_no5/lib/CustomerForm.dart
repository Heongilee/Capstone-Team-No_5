library flutter_calendar_dooboo;

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:recycle/AccountSnapshot.dart';
import 'package:recycle/TakingPicture.dart';
import 'package:recycle/ReservationDTO.dart';

class CustomerForm extends StatefulWidget {
  static const routeName = '/CustomerForm';

  @override
  _CustomerForm createState() => _CustomerForm();
}

class _CustomerForm extends State<CustomerForm> {
  final _address = TextEditingController();
  final _db = Firestore.instance;

  //현재 날짜 객체 생성후 년 월 일 삽입
  static var now = DateTime.now();
  DateTime _currentDate = DateTime(now.year, now.month, now.day);
  DateTime _currentDate2 = DateTime(now.year, now.month, now.day);
  String _currentMonth =
      DateFormat.yMMM().format(DateTime(now.year, now.month, now.day));
  DateTime _targetDateTime = DateTime(now.year, now.month, now.day);

  //날짜에 이벤트 추가하기
  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  List _time = [
    "시간",
    "09:00 ~ 11:00",
    "11:00 ~ 13:00",
    "13:00 ~ 15:00",
    "15:00 ~ 17:00",
    "17:00 ~ 19:00",
    "19:00 ~ 21:00"
  ];

  List<DropdownMenuItem<String>> _dropDownMenuItems;

  String _timeSet;//시간을 담는 변수
  DateTime selectedDate;//선택한 날짜


  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _timeSet = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String time in _time) {
      items.add(new DropdownMenuItem(value: time, child: new Text(time)));
    }
    return items;
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _timeSet = selectedCity;
    });
  }

  Widget build(BuildContext context) {
    final CustomerForm_AccountSnapshot args =
        ModalRoute.of(context).settings.arguments;

    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() { _currentDate2 = date;});
        events.forEach((event) => print(event.title));
        
        selectedDate = date;
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.yellow)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(TakingPicture.routeName));
            }),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '대형 폐기물 수거 신청',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: _buildBody(args),
    );
  }

  Widget _buildBody(CustomerForm_AccountSnapshot args) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height + 193.0,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(10.0)),
                Flexible(
                  // address
                  child: Container(
                    alignment: Alignment(0.0, 0.0),
                    height: 45,
                    margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: Colors.black12),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 60,
                          child: Text(
                            "주소",
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.only(right: 20),
                            child: StreamBuilder<DocumentSnapshot>(
                                stream: _db
                                    .collection('user')
                                    .document(args.currentAccount.documentID)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    final DocumentSnapshot document =
                                        snapshot.data;
                                    _address.text = document['address'];
                                    return TextField(
                                      readOnly: true,
                                      controller: _address,
                                      style: TextStyle(color: Colors.black),
                                      decoration: InputDecoration(
                                        hintText: null,
                                        border: InputBorder.none,
                                        hintStyle:
                                            TextStyle(color: Colors.grey[300]),
                                      ),
                                      cursorColor: Colors.blue,
                                    );
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: _calendarCarousel,
                ), // This trailing comma makes auto-formatting nicer for build methods.
                //custom icon without header
                Container(
                  margin: EdgeInsets.only(
                    top: 30.0,
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: new Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        _currentMonth,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      )),
                      FlatButton(
                        child: Text('PREV'),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year,
                                _targetDateTime.month - 1);
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      ),
                      FlatButton(
                        child: Text('NEXT'),
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(_targetDateTime.year,
                                _targetDateTime.month + 1);
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: _calendarCarouselNoHeader,
                ),

                SizedBox(
                  width: 250,
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      child: DropdownButton(
                        value: _timeSet,
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Text(
                  'Total : XXXX 원',
                  style: TextStyle(fontSize: 20),
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                SizedBox(
                  width: 300,
                  child: RaisedButton(
                      child: Text(
                        '제 출',
                        style: TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () async{
                        myReservation.myJsonObjects = ReservationDTO(reserveId: args.currentAccount.data['id'], reserveDate: DateTime.now(), reserveAddress: args.currentAccount.data['address'], reserveState: "접수 완료", reserveVisitDate: selectedDate, reserveVisitTime: _timeSet, reserveItems: ['어항', '가방류']).toJson();
                        myReservation.accessMyFirestore();
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
