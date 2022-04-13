import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:micro_posting_app/Services/CurrentUserService.dart';
import 'package:micro_posting_app/Services/StorageService.dart';

import '../Models/User.dart';
import '../main.dart';

class RouterService {
  static final RouterService _instance = RouterService._internal();

  User? CurrentUser;

  factory RouterService() {
    return _instance;
  }

  RouterService._internal() {
    // initialization logic
  }

  Future<User?> GetUserDataToCurrentUserService() async {
    Map<String, String> headers = new Map();
    headers["Authorization"] = "Bearer ${StorageService().jwtOrEmpty()}";
    var res = await http.get(Uri.parse("$SERVER_IP/Users/user-data/"),
        headers: headers);
    if (res.statusCode == 200) {
      CurrentUserService currentUserService = CurrentUserService();
      Map<String, dynamic> respLogin = jsonDecode(res.body);
      currentUserService.CurrentUser?.FirstName = respLogin["firstName"];
      currentUserService.CurrentUser?.LastName = respLogin["lastName"];
      currentUserService.CurrentUser?.Id = respLogin["id"];
      currentUserService.CurrentUser?.UserName = respLogin["name"];
      return currentUserService.CurrentUser;
    }
    return null;
  }

  Future<String?> attemptLogIn(String username, String password) async {
    var res = await http.post(Uri.parse("$SERVER_IP/Users/token/"),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({"login": username, "password": password}));
    if (res.statusCode == 200) {
      Map<String, dynamic> jwt_resp = jsonDecode(res.body);
      StorageService().storage.write(key: "jwt", value: jwt_resp['token']);
      return jwt_resp['token'];
    }
    return null;
  }
}
