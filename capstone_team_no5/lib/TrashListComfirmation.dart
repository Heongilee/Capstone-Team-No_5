import 'package:flutter/material.dart';

class signup_text_editing_controller{
  final _id = TextEditingController();
  final _pw = TextEditingController();
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _phoneNum = TextEditingController();
  final _email = TextEditingController();
  final _comfilm = TextEditingController();
  // StreamController _checkboxController_agree = StreamController<bool>()
  //   ..add(false);
  bool agree = false;
}

class TrashListComfirmation extends StatelessWidget with signup_text_editing_controller{
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

  }
}