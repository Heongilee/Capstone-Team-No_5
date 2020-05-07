import 'package:path_provider/path_provider.dart';  // 앱 내부 저장소를 불러오기 위한 path_provier
import 'dart:io';                                   // 파일 읽고 쓰기 위한 라이브러리
import 'dart:async';                                // 내부 저장소 I/O 비동기 작업.
import 'dart:convert';                              // JSON 분석에 필요한 라이브러리.

abstract class MyAppConfigFunction{
  Future<String> get _localPath async{}
  Future<File> get _localFile async{}
  Future<File> writeMyconfig(Map<String, dynamic> m) async{}
  Future<MyApp_config> readMyconfig() async{}
}
class MyApp_config with MyAppConfigFunction{
  static final MyApp_config _getInstance = MyApp_config._internal();
  String _receiveID;
  bool _chkboxID;
  bool _chkboxAUTO;
 String get receiveID => _receiveID;

 set receiveID(String value) => _receiveID = value;

 bool get chkboxID => _chkboxID;

 set chkboxID(bool value) => _chkboxID = value;

 bool get chkboxAUTO => _chkboxAUTO;

 set chkboxAUTO(bool value) => _chkboxAUTO = value;

  // MyApp_config(this._receiveID, this._chkboxID, this._chkboxAUTO);
  factory MyApp_config() => _getInstance;

  MyApp_config._internal({String receiveID = "", bool chkboxID = false, bool chkboxAUTO = false}){
    this._receiveID = receiveID;
    this._chkboxID = chkboxID;
    this._chkboxAUTO = chkboxAUTO;

    print('MyApp_config Singleton Class was created...');
  }

  @override
  String toString() {
    return "{ ${this._receiveID}, ${this._chkboxID}, ${this._chkboxAUTO} }";
  }

  MyApp_config.fromJson(Map<String, dynamic> json)
    : _receiveID = json['receiveID'],
      _chkboxID = json['chkboxID'],
      _chkboxAUTO = json['chkboxAUTO'];
  
  Map<String, dynamic> toJson() =>
  {
    "receiveID" : this._receiveID,
    "chkboxID" : this._chkboxID,
    "chkboxAUTO" : this._chkboxAUTO
  };

  @override
  Future<String> get _localPath async{
    final dir = await getApplicationDocumentsDirectory();

    return dir.path;
  }

  @override
  Future<File> get _localFile async{
    final path = await _localPath;

    return File('$path/MyApp_config.json');
  }

  @override
  Future<File> writeMyconfig(Map<String, dynamic> m) async{
    super.writeMyconfig(m);

    final file = await _localFile;
    return file.writeAsString(jsonEncode(m));
  }
  @override
  Future<MyApp_config> readMyconfig() async{
    super.readMyconfig();

    try {
      final file = await _localFile;

      String contents = await file.readAsString();

      return MyApp_config.fromJson(jsonDecode(contents.trim()));
    } catch (e) {
      print(e.message + ". So, We create a new configuration file.");
      
      return MyApp_config._getInstance;
    }
  }
}
