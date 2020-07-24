import 'dart:async';
import 'package:http/http.dart' as http;

// class EmailerDAO {
//   static final EmailerDAO _instance = EmailerDAO._internal();
//   EmailerDAO._internal() {}

//   factory EmailerDAO() => _instance;

//   Future<EmailerDTO> getReq() async {
//     // Response response; //dio에서 사용하는 것을 가져온 것.
//     // Dio dio = new Dio();
//     // // get request를 함.
//     // response = await dio.get("$API_PREFIX/1");
//     // print(response.data.toString());

//     // ! 조건문을 줘야 하지 않을까...?
//     // Map jsonObj = jsonDecode(response.data);
//     // jsonObj.putIfAbsent("ok", () => true);

//     // response.data로 jsonObject를 들어오게 할 것임.
//     // return new EmailerDTO.fromJson(jsonObj);
//   }

//   Future<void> postReq(EmailerDTO obj) async {
//     // Response response; //dio에서 사용하는 것을 가져온 것.
//     // Dio dio = new Dio();

//     // data는 Map으로 받아서 http 웹 서버로 데이터를 보냄.
//     // Map jsonObj = obj.toJson();

//     // my_data.putIfAbsent("userId", () => 189);
//     // response = await dio.post(API_PREFIX, data: jsonObj);
//     // print(response.data.toString());
//     // --------------------------------------------------------
//     http.Response response;

//     Map jsonObj = obj.toJson();

//     response = await http.get(httpHost.API_PREFIX);
//     print("HTTP TEST_OUTPUT\n" + response.body);

//     return;
//   }
// }

// // 싱글톤 인스턴스 -> EmailerModule.dart 를 import만 하면 어디서나 접근 가능.
// EmailerDAO my_emailer = EmailerDAO();

class EmailerDTO {
  String authenticationCode;
  String receipent;
  bool ok;

  bool get getOk => ok;

  set setOk(bool ok) => this.ok = ok;

  EmailerDTO({
    this.authenticationCode,
    this.receipent,
    this.ok,
  });

  factory EmailerDTO.fromJson(Map<String, dynamic> json) => EmailerDTO(
        authenticationCode: json["authenticationCode"],
        receipent: json["receipent"],
        ok: json["ok"],
      );

  Map<String, dynamic> toJson() => {
        "authenticationCode": authenticationCode,
        "receipent": receipent,
        "ok": ok,
      };
}

EmailerDTO eObj = new EmailerDTO();
