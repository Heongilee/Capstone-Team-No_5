import 'package:fluttertoast/fluttertoast.dart';

class FlutterToastPlugin {
  //getter
  get showMyToastAlertMsg => _showMyToastAlertMsg;

  void _showMyToastAlertMsg(String my_msg) {
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        webBgColor: "#e74c3c",
        timeInSecForIosWeb: 3,
        msg: my_msg);
  }
}

final myFlutterToast = new FlutterToastPlugin();
