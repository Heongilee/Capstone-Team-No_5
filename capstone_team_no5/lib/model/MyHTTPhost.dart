class MyHttp {
  static final MyHttp _instance = new MyHttp._internal();
  static final PROTOCOL = "http";
  static final HOST = "15.164.123.37";
  static final PORT = "3000";
  static final ROUTE = "create-mailer";
  static final _API_PREFIX = "$PROTOCOL://$HOST:$PORT/$ROUTE";

  //getter
  get API_PREFIX => _API_PREFIX;

  factory MyHttp() {
    return _instance;
  }

  MyHttp._internal() {
    // 초기화 코드
  }
}

MyHttp httpHost = new MyHttp();
