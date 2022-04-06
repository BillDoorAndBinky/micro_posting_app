import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class HomePage extends StatelessWidget {
  HomePage(this.jwt, this.payload);

  factory HomePage.fromBase64(String jwt) => HomePage(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;
  String? CurrentUserLogin;

  Future<String?> getUserData() async {
    var res = await http.get(Uri.parse("$SERVER_IP/User/login"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $jwt"
    });
    if (res.statusCode == 200) {
      Map<String, dynamic> respLogin = jsonDecode(res.body);
      CurrentUserLogin = respLogin['UserName'];
      return respLogin['UserName'];
    }
    return null;
  }

  Text getMainPage() {
    return Text("Hi, $CurrentUserLogin!");
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Secret Data Screen")),
        body: Center(
          child: FutureBuilder(
              //future: getUserData(),
              future: http.get(Uri.parse("$SERVER_IP/User/login"), headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $jwt"
              }),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  return Column(
                    children: <Widget>[
                      getMainPage(),
                    ],
                  );
                else
                  return CircularProgressIndicator();
              }),
        ),
      );
}
