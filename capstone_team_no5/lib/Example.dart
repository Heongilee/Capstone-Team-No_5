import 'package:flutter/material.dart';
import 'package:recycle/myNodejsServer/EmailerModule.dart';

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        FlatButton(
          onPressed: () {
            my_emailer.getReq();
          },
          child: Text('Get'),
          color: Colors.orangeAccent,
        ),
        FlatButton(
          onPressed: () {
            my_emailer.postReq();
          },
          child: Text('Post'),
          color: Colors.orangeAccent,
        ),
        FlatButton(
          onPressed: () {
            my_emailer.getReqWzQuery();
          },
          child: Text('Get With Query'),
          color: Colors.orangeAccent,
        ),
      ],
    );
  }
}
