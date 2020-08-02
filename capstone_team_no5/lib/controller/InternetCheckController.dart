import 'dart:io';

import 'package:flutter/material.dart';

class InternetCheckController {
  //getter
  get checkInternetAccess => _checkInternetAccess;

  Future<bool> _checkInternetAccess(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Connected');
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}

final myInternetCheck = new InternetCheckController();
