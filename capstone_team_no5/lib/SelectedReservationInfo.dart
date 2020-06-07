import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectedReservationInfo_TextEditController {
  final _address = TextEditingController();
  final _id = TextEditingController();
  final _reserveDate = TextEditingController();
  final _visitDate = TextEditingController();
  final _visitTime = TextEditingController();
}
class SelectedReservationInfo extends StatefulWidget {
  final myDocumentSnapshot_element;

  SelectedReservationInfo(this.myDocumentSnapshot_element);
  @override
  _SelectedReservationInfoState createState() => _SelectedReservationInfoState();
}

class _SelectedReservationInfoState extends State<SelectedReservationInfo> with SelectedReservationInfo_TextEditController{
  @override
  void initState() {
    super.initState();

    _address.text = widget.myDocumentSnapshot_element["reserveAddress"];
    _id.text = widget.myDocumentSnapshot_element["reserveId"];
    _visitDate.text = widget.myDocumentSnapshot_element["reserveVisitDate"];
    _reserveDate.text = widget.myDocumentSnapshot_element["reserveDate"];
    _visitTime.text = widget.myDocumentSnapshot_element["reserveVisitTime"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text(
        '예약 상세 정보',
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

  Widget _buildBody() {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(), // 스크롤 사이즈 가져오는거 같은데 정확한건 봐야 알듯.
          child: Container(
            height: MediaQuery.of(context).size.height + 200.0,
            child: Column(
              children: <Widget>[
                  Padding(padding: EdgeInsets.all(8.0)),
                  Flexible(
                    // ID
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      height: 45,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.black12),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              "예약자 아이디",
                              style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: TextField(
                                readOnly: true,
                                controller: _id,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                ),
                                cursorColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    // Address
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      height: 45,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.black12),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              "예약자 주소",
                              style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: TextField(
                                readOnly: true,
                                controller: _address,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                ),
                                cursorColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    // reserveDate
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      height: 45,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.black12),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              "예약 날짜",
                              style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: TextField(
                                readOnly: true,
                                controller: _reserveDate,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                ),
                                cursorColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 30.0)),
                      Text("예약 상세 목록", textScaleFactor: 1.2, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  _buildListView(widget.myDocumentSnapshot_element),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 30.0)),
                      Text("물품 사진", textScaleFactor: 1.2, style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  _buildMyTrashImages(widget.myDocumentSnapshot_element),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Flexible(
                    // VisitDate
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      height: 45,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.black12),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              "방문 날짜",
                              style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: TextField(
                                readOnly: true,
                                controller: _visitDate,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                ),
                                cursorColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    // VisitTime
                    child: Container(
                      alignment: Alignment(0.0, 0.0),
                      height: 45,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 5),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.black12),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              "방문 시간",
                              style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: TextField(
                                readOnly: true,
                                controller: _visitTime,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: Colors.grey[300]),
                                ),
                                cursorColor: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _buildListView(DocumentSnapshot myDocumentSnapshot_element) {
    List _currentProducts = myDocumentSnapshot_element['reserveProducts'];
    List _currentDetails = myDocumentSnapshot_element['reserveDetails'];
    return Container(
      width: 300,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Scrollbar(
        child: ListView.builder(
          itemCount: _currentProducts.length * 2,
          itemBuilder: (context, index) {
            if(index.isOdd){
              return Divider();
            }
            else{
              var realIdx = index ~/ 2;

              return _buildListItem(realIdx, _currentProducts, _currentDetails);
            }
          },
        ),
      ),
    );
  }

  Widget _buildListItem(int realIdx, List currentProducts, List currentDetails) {
    return ListTile(
      title: Text(currentProducts[realIdx]),
      subtitle: Text(currentDetails[realIdx]),
    );
  }

  Widget _buildMyTrashImages(myDocumentSnapshot_element) {
    List _currentFiles = myDocumentSnapshot_element['reserveFiles'];

    return Container(
      width: 300,
      height: 300,
      child: Scrollbar(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _currentFiles.length * 2,
          itemBuilder: (context, index) {
            if(index.isOdd){
              return Divider();
            } else{
              var realIdx = index ~/ 2;

              return _buildMyTrashImageItem(realIdx, _currentFiles);
            }
          },
        ),
      ),
    );
  }

  Widget _buildMyTrashImageItem(int realIdx, List currentFiles) {
    return Padding(
      padding: EdgeInsets.only(right: 5.0),
      child: CachedNetworkImage(
        placeholder: (context, url) => CircularProgressIndicator(),
        imageUrl: currentFiles[realIdx],
      ),
    );
  }
}
