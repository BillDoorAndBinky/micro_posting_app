import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Models/User.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();

  final storage = FlutterSecureStorage();

  factory StorageService() {
    return _instance;
  }

  StorageService._internal() {
    // initialization logic
  }

  Future<String> jwtOrEmpty() async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }

  Future<String?> get jwtIsValid async {
    var jwt = await jwtOrEmpty();

    if (jwt == "") return "";

    var payload =
        json.decode(ascii.decode(base64.decode(base64.normalize(jwt[1]))));

    if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
        .isAfter(DateTime.now())) return jwt;
  }

  void clearStorage() {
    StorageService().storage.deleteAll();
  }
}
