import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycle/model/AccountSnapshot.dart';
import 'package:recycle/view/TakingPicture.dart';

class HomePage extends StatelessWidget {
  final DocumentSnapshot _currentAccount;
  final _FAB_size = 220.0;
  final _FAB_Imageicon_size = 140.0;
  int cnt = 0;

  HomePage(this._currentAccount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          '홈',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TODO : 공지 사항이나 다른 컨테이너 추가하기.
            Container(
              width: _FAB_size,
              height: _FAB_size,
              margin: EdgeInsets.all(5.0),
              padding: EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: MaterialButton(
                // 대형 폐기물 수거 신청 처리 작동...
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => MyAccount(_currentAccount)));
                  Navigator.pushNamed(context, TakingPicture.routeName,
                      arguments:
                          TakingPicture_AccountSnapshot(_currentAccount));
                },
                shape: CircleBorder(),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    SizedBox(
                      width: _FAB_size,
                      height: _FAB_size,
                      child: FloatingActionButton(
                        backgroundColor: Colors.grey[200],
                        onPressed: null,
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      child: SizedBox(
                        width: _FAB_Imageicon_size,
                        height: _FAB_Imageicon_size,
                        child: Image(
                            image: AssetImage('assets/icon/Trash_bin.png')),
                        // child: Image.network('https://lh3.googleusercontent.com/proxy/cC_vGiZHgVk-CkvfOB2i-ifB0Km3I2DMhAtDdLuGC1fck8sVrhqhg82LCWyQam124D9un6PZjs9oqEmrT8QcBbdM0oCr1YVMlevLUOybGoYs4o4B_w'),
                        // child: CachedNetworkImage(
                        //   // imageUrl: 'assets/icon/Trash_bin.png',
                        //   imageUrl: 'assets/images/Logo.png',
                        //   // imageUrl: 'https://lh3.googleusercontent.com/proxy/cC_vGiZHgVk-CkvfOB2i-ifB0Km3I2DMhAtDdLuGC1fck8sVrhqhg82LCWyQam124D9un6PZjs9oqEmrT8QcBbdM0oCr1YVMlevLUOybGoYs4o4B_w',
                        //   // progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(),
                        //   errorWidget: (context, url, error) => Icon(Icons.error),
                        // ),
                      ),
                    ),
                    Positioned(
                      bottom: 35.0,
                      child: Text('대형 폐기물 \n  수거 신청',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
