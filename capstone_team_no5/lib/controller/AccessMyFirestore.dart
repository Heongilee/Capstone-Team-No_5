import 'package:cloud_firestore/cloud_firestore.dart';

class AccessMyFirestore {
  static final AccessMyFirestore _singleton =
      new AccessMyFirestore._internal(); // 팩토리 생성자에서 이미 존재하는 것을 사용하도록 한다.
  final _db = Firestore.instance;
  DocumentSnapshot _currentDoc;

  //getter
  DocumentSnapshot get currentDoc => _currentDoc;
  get db => _db;

  //setter
  set currentDoc(dynamic doc) => _currentDoc = doc;

  factory AccessMyFirestore() {
    return _singleton;
  }

  AccessMyFirestore._internal() {}
}

AccessMyFirestore myFirestore = new AccessMyFirestore();
