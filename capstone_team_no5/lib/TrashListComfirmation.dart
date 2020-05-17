import 'package:flutter/material.dart';
import 'dart:io';



class TrashListComfirmation extends StatefulWidget{

  @override
  _TrashListComfirmationState createState() => _TrashListComfirmationState();
}

class _TrashListComfirmationState extends State<TrashListComfirmation> {
  File _image;

  List _cities =
  ["Cluj-Napoca", "Bucuresti", "Timisoara", "Brasov", "Constanta"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;

  String _currentCity;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentCity = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in _cities) {
      items.add(new DropdownMenuItem(
          value: city,
          child: new Text(city)
      ));
    }
    return items;
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,), 
          onPressed: (){
            Navigator.of(context).pop();
          }
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('대형 폐기물 수거 신청',
          style: TextStyle(
            color:Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
          ),
        ),
      ),
      
      body: TrashList(),
    );
  }

  Widget TrashList(){
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(24.0)),
            Container(
              width: 300.0,
              height: 300.0,
              child:
                  Center(
                      child: Image(
                          image: AssetImage('assets/images/pictureGuide.png'))),
            ),
            Padding(padding: EdgeInsets.all(2.0)),
            Text('이 사진은 치워 입니다.', textScaleFactor: 2.0,),
            Padding(padding: EdgeInsets.all(20.0)),

            Text('상세 목록', textScaleFactor: 1.5,),

            SizedBox(
              width: 250,
              child: DropdownButtonHideUnderline(
                 child: ButtonTheme(
                   child: DropdownButton(
                      value: _currentCity,
                      items: _dropDownMenuItems,
                      onChanged: changedDropDownItem,
                  ),
                ),
              ),
            ),

            Padding(padding: EdgeInsets.all(90.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    '다시찍기',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  onPressed: () {

                  }
                ),
                Padding(padding: EdgeInsets.only(left: 40.0, right: 30.0)),
                
                RaisedButton(
                  child: Text(
                    ' 다 음 ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  onPressed: () {

                  }
                ),
              ],
            ),
         ],
       ),
      ),
    );
  }
}