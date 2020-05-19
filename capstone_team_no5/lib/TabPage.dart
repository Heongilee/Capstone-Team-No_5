import 'package:flutter/material.dart';
import 'package:recycle/AccountSnapshot.dart';
import 'package:recycle/HomePage.dart';
import 'package:recycle/MyInfo.dart';
import 'package:recycle/ReservationList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TabPage extends StatefulWidget {
  static const routeName = '/TabPage';

  // final DocumentSnapshot _currentAccount;

  // TabPage(this._currentAccount);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  

  int _selectedIdx = 0;
  List _pages;

  @override
  void initState() {
    super.initState();

    // _pages = [
    //   HomePage(widget._currentAccount),
    //   ReservationList(widget._currentAccount),
    //   MyInfo(widget._currentAccount),
    // ];
  }

  @override
  Widget build(BuildContext context) {
    final TabPage_AccountSnapshot args = ModalRoute.of(context).settings.arguments;

     _pages = [HomePage(args.currentAccount), ReservationList(args.currentAccount), MyInfo(args.currentAccount)];
    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: _pages[_selectedIdx],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        onTap: _onItemTapped,
        currentIndex: _selectedIdx,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('홈')),
          BottomNavigationBarItem(
              icon: Icon(Icons.search), title: Text('예약조회')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('내정보')),
        ],
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIdx = value;
    });
  }
}
