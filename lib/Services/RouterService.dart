import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:micro_posting_app/Services/CurrentUserService.dart';

import '../Models/User.dart';
import '../main.dart';

class RouterService{
  static final RouterService _instance = RouterService._internal();

  User? CurrentUser;

  factory RouterService() {
    return _instance;
  }

  RouterService._internal() {
    // initialization logic
  }

  Future<User?> GetUserDataToCurrentUserService(String jwt) async {
    Map<String, String> headers = new Map();
    headers["Authorization"] = "Bearer $jwt";
    var res = await http.get(Uri.parse("$SERVER_IP/Users/user-data/"), headers: headers);
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
}