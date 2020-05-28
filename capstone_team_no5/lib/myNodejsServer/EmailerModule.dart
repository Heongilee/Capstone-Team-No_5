// import 'dart:convert';
// import 'dart:async';

// const PROTOCOL = "https";
// const HOST = "localhost";
// const ROUTE = "create-mailer";
// const _API_PREFIX = "$PROTOCOL://$HOST/$ROUTE";
// // https://localhost/create-mailer

// class EmailerDAO {
//   static final EmailerDAO _instance = EmailerDAO._internal();
//   EmailerDAO._internal() {}

//   factory EmailerDAO() => _instance;

//   Future<EmailerDTO> getReq() async {
//     Response response; //dio에서 사용하는 것을 가져온 것.
//     Dio dio = new Dio();
//     // get request를 함.
//     response = await dio.get("$_API_PREFIX/1");
//     print(response.data.toString());

//     // ! 조건문을 줘야 하지 않을까...?
//     Map jsonObj = jsonDecode(response.data);
//     jsonObj.putIfAbsent("ok", () => true);

//     // response.data로 jsonObject를 들어오게 할 것임.
//     return new EmailerDTO.fromJson(jsonObj);
//   }

//   Future<void> postReq(EmailerDTO obj) async {
//     Response response; //dio에서 사용하는 것을 가져온 것.
//     Dio dio = new Dio();

//     // data는 Map으로 받아서 http 웹 서버로 데이터를 보냄.
//     Map jsonObj = obj.toJson();

//     // my_data.putIfAbsent("userId", () => 189);
//     response = await dio.post(_API_PREFIX, data: jsonObj);
//     print(response.data.toString());

//     return;
//   }

//   // ↓↓↓ Example annotation ↓↓↓
//   // 웹 서버로 쿼리를 보낼 수 있음. (또 다른 Post 형식.)
//   // https://jsonplaceholder.typicode.com/posts?userId=1&id=3  <-을 보낼것임.
//   // userId 가 1이고, id가 3인 데이터 들을 JsonArray 형태로 받아올 것임.
//   Future<void> getReqWzQuery(EmailerDTO obj) async {
//     Response response; //dio에서 사용하는 것을 가져온 것.
//     Dio dio = new Dio();

//     Map jsonObj = obj.toJson();

//     response = await dio.get(_API_PREFIX, queryParameters: jsonObj);
//     print(response.data.toString());
//   }
// }

// // 싱글톤 인스턴스 -> EmailerModule.dart 를 import만 하면 어디서나 접근 가능.
// EmailerDAO my_emailer = EmailerDAO();

// class EmailerDTO {
//   String authenticationCode;
//   String receipent;
//   bool ok;

//   bool get getOk => ok;

//   set setOk(bool ok) => this.ok = ok;

//   EmailerDTO({
//     this.authenticationCode,
//     this.receipent,
//     this.ok,
//   });

//   factory EmailerDTO.fromJson(Map<String, dynamic> json) => EmailerDTO(
//         authenticationCode: json["authenticationCode"],
//         receipent: json["receipent"],
//         ok: json["ok"],
//       );

//   Map<String, dynamic> toJson() => {
//         "authenticationCode": authenticationCode,
//         "receipent": receipent,
//         "ok": ok,
//       };
// }
