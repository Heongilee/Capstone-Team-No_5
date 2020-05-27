// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:io';

const PROTOCOL = "http";
const ANDROID_HOST = "192.168.2.204";
// const ANDROID_HOST = "10.0.2.2";
const IOS_HOST = "localhost";
const PORT = "8080";
const ROUTE = "create-mailer";

class ExamplePage extends StatefulWidget {
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  String _serverResponse = "N/A";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Http req, res',
          textScaleFactor: 1.2,
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => _makeGetResponse(),
                  child: Text('Send request to Server.'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(_serverResponse),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  _makeGetResponse() async {
    var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 8080);
    print('Listening on ${server.address}:${server.port}');

    await for (var httpRequest in server) {
      httpRequest.response.write('Hello World!');

       await httpRequest.response.close();
    }
  }

  String _localhost() {
    String _api_prefix = "";

    if (Platform.isAndroid)
      _api_prefix = "$PROTOCOL://$ANDROID_HOST:$PORT/$ROUTE";
    else if (Platform.isIOS) _api_prefix = "$PROTOCOL://$IOS_HOST:$PORT/$ROUTE";

    return _api_prefix;
  }
}
